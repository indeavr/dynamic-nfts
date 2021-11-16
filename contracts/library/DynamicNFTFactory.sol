pragma solidity 0.8.10;

import "./DynamicERC721.sol";

abstract contract DynamicNFTFactory is DynamicERC721 {
    constructor () {
    }

    function mint(string memory metadataUri) external onlyOwner {
        super._safeDynamicMint(msg.sender, metadataUri);
    }

    function mintTo(string memory metadataUri, address to) external onlyOwner {
        super._safeDynamicMint(to, metadataUri);
    }
}
