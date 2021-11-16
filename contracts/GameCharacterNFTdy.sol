pragma solidity 0.8.10;

import "./library/DynamicERC721.sol";

contract GameCharNFT is DynamicERC721 {
    constructor () ERC721("GameCharNFT", "GameCharacter"){

    }
}
