// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";

contract NFT is ERC1155Supply, ERC1155URIStorage {
  uint256 public currentNFTCount;

  mapping(string => bool) internal tokenURIExists;
  mapping(uint256 => NaFT) public nftStorage;

  enum Status {
    OffBid,
    OnBid,
    WaittingClaim,
    currentBuy,
    currentAuction,
    sellPrice,
    auctionPrice
  }

  struct SongParticipant {
    string singer;
    string lyricist;
    string composer;
  }

  struct Song {
    string name;
    string genre;
  }

  struct NaFT {
    uint256 tokenID;
    string tokenName;
    string tokenURI;
    address mintedBy;
    address currentOwner;
    uint256 transferTime;
    // Status status;
    SongParticipant songParticipant;
    Song song;
  }

  constructor() ERC1155("NFT") {
    currentNFTCount = 0;
  }

  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal virtual override(ERC1155, ERC1155Supply) {
    super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
  }

  function uri(uint256 tokenId)
    public
    view
    virtual
    override(ERC1155, ERC1155URIStorage)
    returns (string memory)
  {
    // string memory tokenURI = _tokenURIs[tokenId];
    // If token URI is set, concatenate base URI and tokenURI (via abi.encodePacked).
    // return bytes(tokenURI).length > 0 ? string(abi.encodePacked(_baseURI, tokenURI)) : super.uri(tokenId);
  }

  // _tokenIdToTokenURI[_id] = _tokenURI; 등을 구현해야하나?

  function mint(
    string memory _name,
    string memory _tokenURI,
    SongParticipant memory _songParticipant,
    Song memory _song
  ) internal {
    currentNFTCount++;
    require(!exists(currentNFTCount), "NFTID repeated.");
    require(!tokenURIExists[_tokenURI], "Token URI repeated.");

    //새 NFT(구조체)를 만들고 새 값을 전달합니다.

    NaFT memory newNaFT = NaFT(
      currentNFTCount,
      _name,
      _tokenURI,
      msg.sender,
      msg.sender,
      block.timestamp,
      _songParticipant,
      _song
    );

    tokenURIExists[_tokenURI] = true;
    nftStorage[currentNFTCount] = newNaFT;

    //nftStorage[currentNFTCount]
    _mint(msg.sender, currentNFTCount, 0, "11");
    _setURI(currentNFTCount, _tokenURI);
  }
}
