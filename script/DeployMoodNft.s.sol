// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happySvgPath = "img/dynamic/happy.svg";
        string memory sadSvgPath = "img/dynamic/sad.svg";

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            getSvgUri(happySvgPath),
            getSvgUri(sadSvgPath)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    function getSvgUri(
        string memory filePath
    ) public view returns (string memory) {
        string memory svgContent = vm.readFile(filePath);
        return convertSvgToUri(svgContent);
    }

    function convertSvgToUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory prefix = "data:image/svg+xml;base64,";

        return
            string(
                abi.encodePacked(
                    prefix,
                    Base64.encode(bytes(abi.encodePacked(svg)))
                )
            );
    }
}
