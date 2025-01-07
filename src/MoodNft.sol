pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {console} from "forge-std/console.sol";

contract MoodNft is ERC721 {
    //using Strings for uint256;

    error MoodNft__NotApprovedOrOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;

    enum Mood {
        SAD,
        HAPPY
    }

    mapping(uint256 => Mood) private s_tokenIdMood;

    constructor(string memory sadSvg, string memory happySvg) ERC721("Moody", "MNFTy") {
        s_tokenCounter = 0;
        s_sadSvg = sadSvg;
        s_happySvg = happySvg;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNft__NotApprovedOrOwner();
        }

        console.log("Current mood:", uint256(s_tokenIdMood[tokenId])); // 0 = SAD, 1 = HAPPY

        if (s_tokenIdMood[tokenId] == Mood.HAPPY) {
            s_tokenIdMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdMood[tokenId] = Mood.HAPPY;
        }

        console.log("New mood:", uint256(s_tokenIdMood[tokenId]));
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdMood[tokenId] == Mood.SAD) {
            imageUri = s_sadSvg;
        } else {
            imageUri = s_happySvg;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            '", "description": "A moody NFT", "attributes": [{"trait_type": "mood", "value": 100%"}], "image": "',
                            imageUri,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
