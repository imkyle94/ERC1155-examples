// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";

contract NFTCollection is ERC1155Supply {
  string[] public tokenURIs;
  mapping(string => bool) _tokenURIExists;
  mapping(uint256 => string) _tokenIdToTokenURI;

  constructor() ERC1155("NFT") {}

  // function tokenURI(uint256 tokenId)
  //     public
  //     view
  //     override
  //     returns (string memory)
  // {
  //     require(
  //         exists(tokenId),
  //         "ERC721Metadata: URI query for nonexistent token"
  //     );
  //     return _tokenIdToTokenURI[tokenId];
  // }

  function safeMint(string memory _tokenURI) public {
    require(!_tokenURIExists[_tokenURI], "The token URI should be unique");
    tokenURIs.push(_tokenURI);
    uint256 _id = tokenURIs.length;
    _tokenIdToTokenURI[_id] = _tokenURI;

    _mint(msg.sender, _id, 1, "1");

    _tokenURIExists[_tokenURI] = true;
  }
}
