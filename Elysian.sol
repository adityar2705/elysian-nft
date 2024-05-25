// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Elysian is ERC721, ERC721Enumerable, ERC721URIStorage{
    uint256 private _nextTokenId;
    uint256 public MAX_SUPPLY = 1000;
    uint256 public MAX_LIMIT = 20;

    //creating a public NFT balances mapping
    mapping(address => uint256) private balances;

    //configuring the Elysian NFT
    constructor() ERC721("Elysian","ELY"){}

    //safe minting function for Elysian NFT
    function safeMint(address to, string memory uri) public{
        uint256 tokenId = _nextTokenId++;
        require(tokenId <= MAX_SUPPLY,"All the Elysian have been minted.");
        require(balances[to] < MAX_LIMIT,"Cannot mint more than 20 Elysian per address.");
        _safeMint(to,tokenId);
        balances[to] += 1;
        _setTokenURI(tokenId,uri);
    }

    //following are the required overrides by Solidity
    function _update(address to, uint256 tokenId, address auth) internal override(ERC721, ERC721Enumerable) returns(address){
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable){
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory){
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable, ERC721URIStorage) returns (bool){
        return super.supportsInterface(interfaceId);
    }
}
