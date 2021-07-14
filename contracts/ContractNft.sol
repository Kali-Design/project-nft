// SPDX-License-Identifier: MIT
// pragma experimental SMTChecker;
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ContractNft is ERC721, ERC721URIStorage, ERC721Enumerable, AccessControl {
    using Counters for Counters.Counter;
    
    struct ProjectNft {
        string title;
        string creator;
        address creatorAddress;
        // string uri;
        uint256 timestamp; 
        bytes32 nftHash; 
        string content;
    }

    bytes32 public constant CREATOR = keccak256("CREATOR");

    Counters.Counter private _tokenID; 
    mapping(bytes32 => uint256) private _nftID; 
    mapping(uint256 => ProjectNft) private _nft; 

    event Created(string title, string creator_, address indexed creatorAddress, uint256 timestamp, bytes32 indexed nftHash,string content_, uint256 indexed currentId);

    constructor() ERC721("ProjectNft", "NFTI") {
        _setupRole(CREATOR, msg.sender);
    }
    function CreateNft(address creatorAddress, string memory title_, string memory creator_ ,string memory content_, string memory uri_, bytes32 nftHash ) public onlyRole(CREATOR) returns (uint256) {
        require(_nftID[nftHash] == 0, "ProjectNft: Sorry, this NFT is already existed");
        _tokenID.increment();
        uint256 currentId = _tokenID.current();
        uint256 timestamp = block.timestamp;
        _mint(creatorAddress, currentId);
        _setTokenURI(currentId, uri_);
        _nft[currentId] = ProjectNft(title_, creator_, creatorAddress, timestamp, nftHash, content_);
        _nftID[nftHash] = currentId;
        emit Created(title_, creator_, creatorAddress, timestamp, nftHash, content_, currentId);
        return currentId;
    }
        function getNftById(uint256 id) public view returns (ProjectNft memory) {
        return _nft[id];
    }

        function getNftIdByHash(bytes32 nftHash) public view returns (uint256) {
        return _nftID[nftHash];
    }
        function tokenURI(uint256 tokenId) public view virtual override(ERC721URIStorage, ERC721) returns (string memory) {
        return super.tokenURI(tokenId);
    }
       function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
        function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
        function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

}