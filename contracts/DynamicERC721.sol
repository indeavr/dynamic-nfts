pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DynamicERC721 is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    string baseURI;

    string public constant URI = "https://gateway.pinata.cloud/ipfs/";

    struct UpgradeInfo {
        string metadata;
        uint updateId;
        // if one id = [1,1], if for all [0,10000]
        uint[2] idRange;
    }

    // [NFT] -> info
    mapping(address => UpgradeInfo) public upgrades;

    // [id] -> tokenURI
    mapping(uint => string) public tokenURIs;

    constructor () ERC721("DynamicERC721", "DynamicNft"){
        tokenCounter = 0;
    }

    modifier onlyWhitelisted(bytes bytecode) {
        if (!this.inWhitelist(bytecode)) {
            emit Event(revertMessage);
            revert(revertMessage);
        }
        require(bytecode.length != 0, 'ERROR: Zero address');
        require(this.inWhitelist(_nftContract), 'ERROR: Not Whitelisted');
        _;
    }

    modifier onlyMine(uint id){
        require(ownerOf(id) == msg.sender, "Not owned");
        _;
    }

    /*
        This collection is part of the spec and it's required for the generation script to work.
    */
    mapping(uint => bytes) properties;

    function changeProperty(bytes key, bytes value) {

    }

    function readProperty(){

    }

    /* where does the converstion between bytes & actual type happen ? */
    function getProperties(){

    }

    // hmm maybe add "functions to execute" inside the upgrade object / struct ?
    function upgrade(uint id, uint updateId) onlyMine(id) {

    }

    // base function called only for metadata
    function addUpgrade(uint tokenId, string tokenUri){

    }

    bool autoAcceptUpgrades = false;

    /*
        Can be overridden to always return true/false
    */
    function shouldAutoAccept(){
        return autoAcceptUpgrades;
    }

    /*
        Can be overridden to be disabled
    */
    function toggleAutoAccept(bool newVal){
        autoAcceptUpgrades = newVal;
        // emit Event
    }


    function addToWhitelist(byte[] bytecode) public onlyOwner {
        require(inWhitelist(bytecode) == false, "Already in whitelist");
        uint l = whitelist.length;
        bool replaced = false;
        for (uint i = 0; i < l; i++) {
            if (address(whitelist[i]) == address(0)) {
                whitelist[i] = bytecode;
                replaced = true;
            }
        }
        if (!replaced) {
            whitelist.push(bytecode);
        }
    }

    function removeFromWhitelist(byte[] bytecode) public onlyOwner {
        uint l = whitelist.length;
        for (uint i = 0; i < l; i++) {
            if (address(whitelist[l]) == address(_nftContract)) {
                delete whitelist[l];
            }
        }
    }

    function tokenURI(uint256 tokenId) public view override (ERC721) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        // store a mapping with each id and its uri !
    }

    function setTokenURI(
        uint256 tokenId,
        string memory tokenURI
    ) external {
        _setTokenURI(tokenId, tokenURI);
    }

    function setBaseURI(string memory baseURI_) external {
        baseURI = baseURI_;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    // Deal with BNB
    fallback() external payable {}

    receive() external payable {}
}
