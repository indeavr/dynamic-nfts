pragma solidity 0.8.10;

import "./DynamicERC721.sol";

contract DynamicNFTFactory is DynamicERC721 {
    constructor () ERC721("DYERC721", "DynamicNft"){
    }

    function mint(string metadataUri) onlyOwner {
        super._safeDynamicMint(msg.sender, metadataUri);
    }

    function mintTo(string metadataUri, address to) onlyOwner {
        super._safeDynamicMint(to, metadataUri);
    }
}
