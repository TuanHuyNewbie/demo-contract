// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ERC721{
    event Transfer(address indexed _form, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    //1
    mapping(address => uint256) internal _balances;
    //2
    mapping(uint256 => address) internal _owners; 
    //3
    mapping(address => mapping(address => bool)) private _operatorApprivals; 
    //4
    mapping(uint256 => address) private _tokenApprovals;
    // return the number of NFTs  of an user 1
    function balanceOf(address owner) external view returns (uint256){  
        require(owner != address(0), "Not address");
        return _balances[owner];
    }
    //Find the owner of an NFT 2
    function ownerOf(uint256 tokenId) public view returns (address){
        address owner = _owners[tokenId];
        require(owner != address(0), "Token ID not found");
        return owner;
    }

    //enable or disable an operator 3
    function setApprovalForAll(address operator, bool approved) external{
        _operatorApprivals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }
    
    //check if an address is an operator for another address
    function isApprovedForAll(address owner, address operator) public view returns (bool){
        return _operatorApprivals[owner][operator];
    }
    //updates an approved address for an NFT 
    function approve(address to, uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "msg.sender is not the owner of the approved operator");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }
    //gets the approved address for an NFT
    function getApproved(uint256 tokenId) public view returns (address){
        require( _owners[tokenId] != address(0), "Token ID does not exits");
        return _tokenApprovals[tokenId];
    }
    //Transfer ownership of a single
    function transferFrom(address from, address to, uint256 tokenId) public payable{
        
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || 
            getApproved(tokenId) == msg.sender ||
            isApprovedForAll(owner, msg.sender), "msg.sender is not the owner of the approved operator");
        require(owner == from, "from address is not the owner");
        require(to != address(0), "Address is the zero address");
        approve(address(0), tokenId); 
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }
    
    // standard transferFrom method
    //check if the receiver smart contract is capable of receiving NFT
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable{
        safeTransferFrom1(from, to, tokenId);
    }

    function safeTransferFrom1(address from, address to, uint256 tokenId) public payable{
        
        transferFrom(from, to, tokenId);
        require(_checkERC(), "Receiver not implemented");

    }
    //simple version to check for NFT receivability of a smart contract
    function _checkERC() private pure returns(bool){
        return true;
    } 
    
    
    //EIP165 proposal: query if a contract implements another interface
    function suportInterface(bytes4 interfaceID) public pure virtual returns(bool){
        return interfaceID == 0x80ac58cd;  
    } 

}