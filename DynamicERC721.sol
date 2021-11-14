pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DynamicERC721 is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    string baseURI;

    string public constant URI = "https://gateway.pinata.cloud/ipfs/";

    struct UpgradeInfo {
        string metadata;
    }

    // [NFT] -> info
    mapping(address => UpgradeInfo[]) public upgrades;

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

    function onlyMinter(address caller, uint tokenId){
        require(minters[tokenId] == caller, "Only minter is authorized");
        _;
    }

    function _safeDynamicMint(address account, string tokenURI){
        super._safeMint(account, tokenCounter);
        setTokenURI(tokenCounter, tokenURI);

        tokenCounter++;
    }

    function readProperty(){

    }

    /* where does the converstion between bytes & actual type happen ? */
    function getProperties(){

    }

    // hmm maybe add "functions to execute" inside the upgrade object / struct ?
    function upgrade(uint id, uint updateIndex) onlyMine(id) {
        _upgrade(id, updateIndex);
    }

    function _upgrade(uint id, uint updateIndex) internal {
        require(upgrades[id].length > updateIndex, "Invalid id or updateIndex");
        UpgradeInfo upgradeInfo = upgrades[id][updateIndex];
        setTokenURI(upgradeInfo.metadata);
        // emit event
    }

    // base function called only for metadata
    function addUpgrade(uint tokenId, string tokenUri)
    public
    onlyMinter(msg.sender, tokenId)
    {
        UpgradeInfo upgradeInfo = UpgradeInfo(tokenUri);
        upgrades[tokenURI].push(upgradeInfo);
        // emit event
        bool auto = shouldAutoAccept();
        if (auto) {
            _upgrade(id, upgrades[tokenURI].length - 1);
            // emit event
        }
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

    function tokenURI(uint256 tokenId) public view override (ERC721) returns (string memory) {
        require(_exists(tokenId), "URI query for nonexistent token");
        // store a mapping with each id and its uri !
        return tokenURIs[tokenCounter];
    }

    function setTokenURI(
        uint256 tokenId,
        string memory tokenURI
    ) external {
        tokenURIs[tokenCounter] = tokenURI;
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
