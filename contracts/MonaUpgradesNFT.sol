pragma solidity 0.8.10;

import "./lib/DynamicERC721.sol";

contract MonaUpgradesNFT is DynamicERC721 {
    constructor () ERC721("MonaUpgradesNFT", "MonaUpgradesNFTCollectiongyhb"){
    }

    function mint(string memory metadataUri) public {
        super._safeDynamicMint(msg.sender, metadataUri);
    }

    function mintTo(string memory metadataUri, address to) public {
        super._safeDynamicMint(to, metadataUri);
    }
}
