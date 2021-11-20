pragma solidity 0.8.10;

import "./lib/DynamicERC721.sol";

contract AvatarNFTdy is DynamicERC721 {
    constructor () ERC721("DYERC721", "DynamicNft"){
    }

    function mint(string calldata metadataUri) public onlyOwner {
        super._safeDynamicMint(msg.sender, metadataUri);
    }

    function mintTo(string calldata metadataUri, address to) public onlyOwner {
        super._safeDynamicMint(to, metadataUri);
    }
}
