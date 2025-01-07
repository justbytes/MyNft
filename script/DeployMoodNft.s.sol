pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    MoodNft public moodNft;

    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        vm.startBroadcast();
        moodNft = new MoodNft(sadSvg, happySvg);
        vm.stopBroadcast();

        return moodNft;
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        return string.concat("data:image/svg+xml;base64,", Base64.encode(bytes(string(abi.encodePacked(svg)))));
    }
}
