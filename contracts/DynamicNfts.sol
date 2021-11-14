pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DynamicNft is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    string public constant URI = "https://gateway.pinata.cloud/ipfs/";

    constructor () ERC721("DynamicNft", "SmartNft"){
        tokenCounter = 0;
    }
}
