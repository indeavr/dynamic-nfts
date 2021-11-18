pragma solidity 0.8.10;

import "./DynamicERC721.sol";

abstract contract DynamicNFTFactory is DynamicERC721 {
    constructor () {
    }

    function canMint(address sender) public virtual returns (bool){
        return sender == this.owner();
    }

    function mint(string memory metadataUri) public virtual {
        require(canMint(msg.sender), "Cant Mint !");
        super._safeDynamicMint(msg.sender, metadataUri);
    }

    function mintTo(string memory metadataUri, address to) public virtual{
        super._safeDynamicMint(to, metadataUri);
    }
}
