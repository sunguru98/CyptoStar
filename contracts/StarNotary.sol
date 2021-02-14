// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24;

//Importing openzeppelin-solidity ERC-721 implemented Standard
import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";

// StarNotary Contract declaration inheritance the ERC721 openzeppelin implementation
contract StarNotary is ERC721Full {
  // Star data
  struct Star {
    string name;
  }

  // name: Is a short name to your token
  string public name;
  // symbol: Is a short string like 'USD' -> 'American Dollar'
  string public symbol;

  // Implement Task 1 Add a name and symbol properties
  constructor(string memory _n, string memory _s) public ERC721Full(_n, _s) {
    name = _n;
    symbol = _s;
  }

  // mapping the Star with the Owner Address
  mapping(uint256 => Star) public tokenIdToStarInfo;
  // mapping the TokenId and price
  mapping(uint256 => uint256) public starsForSale;

  // Create Star using the Struct
  function createStar(string memory _name, uint256 _tokenId) public {
    // Passing the name and tokenId as a parameters
    Star memory newStar = Star(_name); // Star is an struct so we are creating a new Star
    tokenIdToStarInfo[_tokenId] = newStar; // Creating in memory the Star -> tokenId mapping
    _mint(msg.sender, _tokenId); // _mint assign the the star with _tokenId to the sender address (ownership)
  }

  // Putting an Star for sale (Adding the star tokenid into the mapping starsForSale, first verify that the sender is the owner)
  function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
    require(
      ownerOf(_tokenId) == msg.sender,
      "You can't sale the Star you don't owned"
    );
    starsForSale[_tokenId] = _price;
  }

  // Function that allows you to convert an address into a payable address
  function _make_payable(address x) internal pure returns (address payable) {
    return address(uint160(x));
  }

  function buyStar(uint256 _tokenId) public payable {
    require(starsForSale[_tokenId] > 0, "The Star should be up for sale");
    uint256 starCost = starsForSale[_tokenId];
    address ownerAddress = ownerOf(_tokenId);
    require(msg.value > starCost, "You need to have enough Ether");
    _transferFrom(ownerAddress, msg.sender, _tokenId); // We can't use _addTokenTo or_removeTokenFrom functions, now we have to use _transferFrom
    address payable ownerAddressPayable = _make_payable(ownerAddress); // We need to make this conversion to be able to use transfer() function to transfer ethers
    ownerAddressPayable.transfer(starCost);
    if (msg.value > starCost) {
      msg.sender.transfer(msg.value - starCost);
    }
  }

  // Implement Task 1 lookUptokenIdToStarInfo
  function lookUptokenIdToStarInfo(uint256 _tokenId)
    public
    view
    returns (string memory)
  {
    //1. You should return the Star saved in tokenIdToStarInfo mapping
    string memory star = tokenIdToStarInfo[_tokenId].name;
    require(bytes(star).length > 0, "StarNotary: invalid token id");
    return star;
  }

  // Implement Task 1 Exchange Stars function
  function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public {
    address owner1 = ownerOf(_tokenId1);
    address owner2 = ownerOf(_tokenId2);
    require(
      owner1 == msg.sender || owner2 == msg.sender,
      "StarNotary: requested tokens are neither owned by caller"
    );
    _transferFrom(owner1, owner2, _tokenId1);
    _transferFrom(owner2, owner1, _tokenId2);
  }

  // Implement Task 1 Transfer Stars
  function transferStar(address _to1, uint256 _tokenId) public {
    //1. Check if the sender is the ownerOf(_tokenId)
    address owner = ownerOf(_tokenId);
    require(
      owner == msg.sender,
      "StarNotary: requested token not owned by caller"
    );
    //2. Use the transferFrom(from, to, tokenId); function to transfer the Star
    transferFrom(owner, _to1, _tokenId);
  }
}
