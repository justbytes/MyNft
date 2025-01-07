pragma solidity ^0.8.18;

import {BasicNft} from "../src/BasicNft.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant DOG_METADATA_URI = "ipfs://Qmf5Q5aZbB1UJf3YT9R2T6dRBpqTL8bd63TR7hRekKorbD";

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        BasicNft(mostRecentlyDeployed).mintNft(DOG_METADATA_URI);
        vm.stopBroadcast();
    }
}
