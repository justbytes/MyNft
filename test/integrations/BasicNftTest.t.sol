pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant DOG_METADATA_URI = "ipfs://Qmf5Q5aZbB1UJf3YT9R2T6dRBpqTL8bd63TR7hRekKorbD";

    function setUp() public {
        DeployBasicNft deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNameIsCorrect() public view {
        assert(keccak256(abi.encodePacked(basicNft.name())) == keccak256(abi.encodePacked("Doggo")));
    }

    function testCanMintAndHasBalance() public {
        vm.prank(USER);
        basicNft.mintNft(DOG_METADATA_URI);
        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(DOG_METADATA_URI)));
    }
}
