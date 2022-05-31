// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";

contract A is ERC1155Supply, ERC1155URIStorage {
  enum Status {
    OffBid,
    OnBid,
    WaittingClaim
  }

  struct Image {
    uint256 tokenID;
    string tokenName;
    string tokenURI;
    address mintedBy;
    address currentOwner;
    uint256 transferTime;
    uint256 highestBidPrice;
    Status status;
  }

  uint256 public currentImageCount;

  mapping(uint256 => Image) public imageStorage;

  mapping(uint256 => address[]) public ownerShipTrans;

  mapping(string => bool) internal tokenURIExists;

  constructor() ERC1155("NFT") {}

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

  function mint(
    address to,
    string memory _name,
    string memory _tokenURI
  ) internal returns (uint256) {
    currentImageCount++;
    require(!exists(currentImageCount), "ImageID repeated.");
    require(!tokenURIExists[_tokenURI], "Token URI repeated.");

    _mint(to, currentImageCount, 1, "1");
    _setURI(currentImageCount, _tokenURI);

    //새 NFT(구조체)를 만들고 새 값을 전달합니다.
    Image memory newImage = Image(
      currentImageCount,
      _name,
      _tokenURI,
      msg.sender,
      msg.sender,
      0,
      0,
      Status.OffBid
    );

    tokenURIExists[_tokenURI] = true;
    imageStorage[currentImageCount] = newImage;

    return currentImageCount;
  }

  function getImageByIndex(uint256 index)
    internal
    view
    returns (Image memory image)
  {
    require(exists(index), "index not exist");
    return imageStorage[index];
  }

  function updateStatus(uint256 _tokenID, Status status)
    internal
    returns (bool)
  {
    Image storage image = imageStorage[_tokenID];
    image.status = status;
    return true;
  }

  function updateOwner(uint256 _tokenID, address newOwner)
    internal
    returns (bool)
  {
    Image storage image = imageStorage[_tokenID];
    ownerShipTrans[_tokenID].push(image.currentOwner);
    image.currentOwner = newOwner;
    image.transferTime += 1;

    // _transfer(ownerOf(_tokenID), newOwner, _tokenID);
    return true;
  }

  function updatePrice(uint256 _tokenID, uint256 newPrice)
    internal
    returns (bool)
  {
    Image storage image = imageStorage[_tokenID];
    if (image.highestBidPrice < newPrice) {
      image.highestBidPrice = newPrice;
      return true;
    }
    return false;
  }

  //   function getTokenOnwer(uint256 _tokenID) external view returns (address) {
  //     return ownerOf(_tokenID);
  //   }

  function getTokenURI(uint256 _tokenID) external view returns (string memory) {
    Image memory image = imageStorage[_tokenID];
    return image.tokenURI;
  }

  //   function getOwnedNumber(address owner) external view returns (uint256) {
  //     return balanceOf(owner);
  //   }
}
