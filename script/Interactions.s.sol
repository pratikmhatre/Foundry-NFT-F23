// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string constant NFT_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address basicNftAddress = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );

        mintBasicNftWithAddress(basicNftAddress);
    }

    function mintBasicNftWithAddress(address basicNftAddress) public {
        vm.startBroadcast();
        BasicNft(basicNftAddress).mintToken(NFT_URI);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintMoodNftWithAddress(contractAddress);
    }

    function mintMoodNftWithAddress(address nftAddress) internal {
        vm.startBroadcast();
        MoodNft(nftAddress).mintToken();
        vm.stopBroadcast();
    }
}

contract FlipMoodNftToken is Script {
    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        flipMoodNftWithAddress(contractAddress);
    }

    function flipMoodNftWithAddress(address nftAddress) internal {
        vm.startBroadcast();
        MoodNft(nftAddress).flipToken(0);
        vm.stopBroadcast();
    }
}
