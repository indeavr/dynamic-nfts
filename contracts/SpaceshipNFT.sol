pragma solidity 0.8.10;

import "./lib/DynamicERC721.sol";

contract SpaceshipNFT is DynamicERC721 {
    constructor () ERC721("StrategyGame", "DynamicStrategyNft"){
    }

    function mint(string calldata metadataUri) external onlyOwner {
        super._safeDynamicMint(msg.sender, metadataUri);
    }

    function mintTo(string calldata metadataUri, address to) external onlyOwner {
        super._safeDynamicMint(to, metadataUri);
    }
}
