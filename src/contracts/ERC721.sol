//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Building out the minting function
        1. NFT to point to an address
        2. keep track of the token id
        3. keep track of token owners addresses to token ids
        4. Keep track of how many tkens an owner address has
        5. create an event that emits a transfer log - contract address
        where its bein minting to and the id. 


     */

contract ERC721 {

    event Transfer(
    address indexed from, 
    address indexed to, 
    uint256 indexed tokenId);

//hashtable of key pair values
mapping(uint => address) private _tokenOwner; 


//mapping owner to number of owned tokens

mapping(address => uint) private _OwnedTokensCount;

function balanceOf(address _owner) public view returns(uint256) {
    require(_owner != address(0), 'owner query for nonexistent token');
    return  _OwnedTokensCount[_owner];

}

function ownerOf(uint256 _tokenId) external view returns (address) {
    address owner = _tokenOwner[_tokenId];
    require(owner != address(0), 'owner query for nonexistent token');
    return owner;
}


function _exists(uint256 tokenId) internal view returns(bool) {
    //setting the address of the nft owner to to check mapping of the address
    //from the tokenowner at the tokenid
    address owner = _tokenOwner[tokenId];
    //return truthiness that address is not zero
    return owner != address(0);

}

function _mint(address to, uint256 tokenId) internal virtual {
// requires that the address isn't zero
require(to != address(0), 'ERC721: minting to the zero address');
// requires that the token does not already exist. 
require(!_exists(tokenId), 'ERC721: Token already minted'); 
// adding a new address with a token id for minting
_tokenOwner[tokenId] = to;
// keeping track of each address that is minting and adding one to the count.
 _OwnedTokensCount[to] += 1;

emit Transfer(address(0), to, tokenId);


}


}