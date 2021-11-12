//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    //mapping from tokenId to positon in _allTokens array
    //mapping of owner to list of all owner token ids
    //mapping from tokenid index of the owner tokens list

    mapping(uint256 => uint256) private _allTokensIndex;

    mapping(address => uint256[]) private _ownedTokens;

    mapping(uint256 => uint256) private _ownedTokensIndex;

//function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns(uint256);

function _mint(address to, uint256 tokenId) internal override(ERC721) {
    super._mint(to, tokenId);
    //add tokens to the owner
    //add tokens to our total supply - to all tokens
    //we want to execute this function with minting
    _addTokensToAllEnumeration(tokenId);
    _addTokensToOwnerEnumeration(to, tokenId);


    }

    //add token to the _allTokens array and set the position of the tokens idexes

    function _addTokensToAllEnumeration(uint256 tokenId) private {
     _allTokensIndex[tokenId] = _allTokens.length;
     _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }
    //two functions - return tokenByIndex
    //returns tokenOfOwnerByIndex

    function tokenByIndex(uint256 index) public view returns(uint256) {
        //check index is not out of bounds of the total supply
        require(index < totalSupply(), 'global index is out of bounds');
        return _allTokens[index];

    }

    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint256) {
        require(index < balanceOf(owner), 'owner index is out of bounds');
        return _ownedTokens[owner][index];
    }



    //return the total supply of the _allTokens array

    function totalSupply() public view returns(uint256) {
        return _allTokens.length;
    }
      
    

}