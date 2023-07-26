// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft private basicNft;
    string constant NFT_URI =
        "ipfs://bafybeifcfhaet6f67efixu4sui6k4vpla4hy2lq26rhvfpecmi5mackbbu";

    address constant USER = address(1);

    function setUp() external {
        DeployBasicNft deploy = new DeployBasicNft();
        basicNft = deploy.run();
    }

    function testNameMatchesTokenName() external view {
        string memory expectedName = "Doggie";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testMintIncreasesUserBalance() external {
        vm.prank(USER);
        basicNft.mintToken(NFT_URI);

        //check if user balance increases
        assert(basicNft.balanceOf(USER) == 1);

        //test uri matches
        assert(getBytes(basicNft.getUriByTokenId(0)) == getBytes(NFT_URI));
    }

    function getBytes(string memory s) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(s));
    }
}
