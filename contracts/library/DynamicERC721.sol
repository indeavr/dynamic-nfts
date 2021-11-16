pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract DynamicERC721 is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    string baseURI;

    string public constant URI = "https://gateway.pinata.cloud/ipfs/";

    struct UpgradeInfo {
        string metadata;
    }

    // [NFT] -> info
    mapping(uint => UpgradeInfo[]) public upgrades;

    mapping(uint => address) public minters;

    // [id] -> tokenURI
    mapping(uint => string) public tokenURIs;

    constructor () {
        tokenCounter = 0;
    }

    modifier onlyMine(uint id){
        require(ownerOf(id) == msg.sender, "Not owned");
        _;
    }

    /*
        This collection is part of the spec and it's required for the generation script to work.
    */
    mapping(uint => bytes) properties;

    function changeProperty(bytes calldata key, bytes calldata value) public {

    }

    modifier onlyMinter(address caller, uint tokenId){
        require(minters[tokenId] == caller, "Only minter is authorized");
        _;
    }

    function _safeDynamicMint(address account, string memory tokenURI) public {
        uint newTokenId = tokenCounter;
        tokenCounter++;
        setTokenURI(newTokenId, tokenURI);
        minters[tokenCounter] = account;

        super._safeMint(account, newTokenId);
    }

    function readProperty() public {

    }

    /* where does the converstion between bytes & actual type happen ? */
    function getProperties() public{

    }

    // hmm maybe add "functions to execute" inside the upgrade object / struct ?
    function upgrade(uint id, uint updateIndex) public onlyMine(id) {
        _upgrade(id, updateIndex);
    }

    function _upgrade(uint id, uint updateIndex) internal {
        require(upgrades[id].length > updateIndex, "Invalid id or updateIndex");
        UpgradeInfo memory upgradeInfo = upgrades[id][updateIndex];
        setTokenURI(id, upgradeInfo.metadata);
        // emit event
    }

    // base function called only for metadata
    function addUpgrade(uint tokenId, string calldata tokenUri)
    public
    onlyMinter(msg.sender, tokenId)
    {
        UpgradeInfo memory upgradeInfo = UpgradeInfo(tokenUri);
        upgrades[tokenId].push(upgradeInfo);
        // emit event
        bool autoAc = shouldAutoAccept();
        if (autoAc) {
            _upgrade(tokenId, upgrades[tokenId].length - 1);
            // emit event
        }
    }

    bool autoAcceptUpgrades = false;

    /*
        Can be overridden to always return true/false
    */
    function shouldAutoAccept() public returns (bool){
        return autoAcceptUpgrades;
    }

    /*
        Can be overridden to be disabled
    */
    function toggleAutoAccept(bool newVal) public {
        autoAcceptUpgrades = newVal;
        // emit Event
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "URI query for nonexistent token");
        // store a mapping with each id and its uri !
        return tokenURIs[tokenCounter];
    }

    function setTokenURI(
        uint256 tokenId,
        string memory tokenURI
    ) public {
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
