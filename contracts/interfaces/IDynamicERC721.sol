pragma solidity 0.8.10;

interface DynamicERC721 {
    function changeProperty(bytes calldata key, bytes calldata value) external;

    function _safeDynamicMint(address account, string memory metadataUri) external;

    function readProperty(uint) external returns (uint);

    /* where does the converstion between bytes & actual type happen ? */
    function getProperties() external;

    // hmm maybe add "functions to execute" inside the upgrade object / struct ?
    function upgrade(uint id, uint updateIndex) external;

    // base function called only for metadata
    function addUpgrade(uint tokenId, string memory metadataUri) external;

    /*
        Can be overridden to always return true/false
    */
    function shouldAutoAccept() external returns (bool);

    /*
        Can be overridden to be disabled
    */
    function toggleAutoAccept(bool newVal) external;

    function tokenURI(uint256 tokenId) external view returns (string memory);

    function getUpgrades(uint tokenId) external view returns (string[] memory uris);
}
