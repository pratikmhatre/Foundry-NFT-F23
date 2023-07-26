// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    mapping(uint256 => string) private s_tokenIdToUri;
    uint256 private s_tokenCounter = 0;

    constructor() ERC721("Doggie", "D") {}

    function tokenUri(uint256 tokenId) public view returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }

    function mintToken(string memory uri) public {
        s_tokenIdToUri[s_tokenCounter] = uri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    function getUriByTokenId(
        uint256 tokenId
    ) public view returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
