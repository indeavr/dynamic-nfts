pragma solidity 0.8.10;

import "./library/DynamicNFTFactory.sol";

contract DyFactory is DynamicNFTFactory {
    constructor () ERC721("DyFactory", "DyFactory") {

    }

    function canMint(address sender) public override returns (bool){
        return true;
    }

}
