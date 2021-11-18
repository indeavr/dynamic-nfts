pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract DynamicERC721 is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    string baseURI;

    struct UpgradeInfo {
        string metadata;
        bool available;
        bool isSet;
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

    modifier onlyMinterAndOwner(address caller, uint tokenId){
        require(minters[tokenId] == caller || owner() == caller, "Only minter & owner");
        _;
    }

    function _safeDynamicMint(address account, string memory metadataUri) public {
        uint newTokenId = tokenCounter;
        setTokenURI(newTokenId, metadataUri);
        minters[newTokenId] = account;

        super._safeMint(account, newTokenId);
        tokenCounter++;
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
    function addUpgrade(uint tokenId, string memory metadataUri)
    public
    onlyMinterAndOwner(msg.sender, tokenId)
    {
        _addUpgrade(tokenId, metadataUri);
    }

    function _addUpgrade(uint tokenId, string memory metadataUri) internal {
        UpgradeInfo memory upgradeInfo = UpgradeInfo(metadataUri, true, false);
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
        return tokenURIs[tokenId];
    }

    function setTokenURI(
        uint256 tokenId,
        string memory metadataUri
    ) internal {
        tokenURIs[tokenId] = metadataUri;
    }

    function setBaseURI(string memory baseURI_) external {
        baseURI = baseURI_;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function getUpgrades(uint tokenId) external view returns (string[] memory uris){
        UpgradeInfo[] memory info = upgrades[tokenId];
        uris = new string[](info.length);

        for (uint i = 0; i < info.length; i++) {
            uris[i] = info[i].metadata;
        }

        return uris;
    }

    // Deal with BNB
    fallback() external payable {}

    receive() external payable {}
}
