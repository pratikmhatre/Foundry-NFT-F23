// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    enum Mood {
        HAPPY,
        SAD
    }
    uint256 s_tokenCounter;
    string private s_happyImageUri;
    string private s_sadImageUri;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory happyImageUri,
        string memory sadImageUri
    ) ERC721("MoodNFT", "MN") {
        s_tokenCounter = 0;
        s_happyImageUri = happyImageUri;
        s_sadImageUri = sadImageUri;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri = s_happyImageUri;
        if (s_tokenIdToMood[tokenId] == Mood.SAD) {
            imageUri = s_sadImageUri;
        }
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '","description":"Describes the mood of its owner", "image":"',
                                imageUri,
                                '", "traits":[{"trait_type":"intensity", "value":100}]'
                            )
                        )
                    )
                )
            );
    }

    function flipToken(uint256 tokenId) public {
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function mintToken() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }
}
