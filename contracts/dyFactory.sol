pragma solidity 0.8.10;

import "./library/DynamicNFTFactory.sol";

contract dyFactory is DynamicNFTFactory {
    constructor () ERC721("dyFactory", "dyFactory"){

    }
}
