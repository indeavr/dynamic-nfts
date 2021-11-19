pragma solidity 0.8.10;

import "./flat/DyF.sol";

contract WeaponNFTFactory is DynamicNFTFactory {
    constructor () ERC721("WeaponNFTFactory", "DynamicWeaponNFTFactory"){
    }

    string public one = "ipfs://QmbmFeLvymjNYyuS3xHfBvyAHtD3vrKp7NdLWsJpRM91bm";
    string public two = "ipfs://QmXcAFAF9zvxnAjdjxaPKpUge9LBPWhiYsTtDWxGndtxJC";
    string public three = "ipfs://QmW9vC4CZP3XfZwHcaDcFJ4amWP8HLHfHXWQQiLEakfW5A";
    string public four = "ipfs://QmNQYgLUEqimdSfBdMRzom9pedMEUSvyLShK16c8uF3NhU";


    struct Weapon {
        uint level;
        uint damage;
        uint agility;
    }

    mapping(uint => Weapon) weapons;


    function mint(string memory metadataUri) public override {
        require(canMint(msg.sender), "Cant Mint !");



        super._safeDynamicMint(msg.sender, metadataUri);
    }

    function mintTo(string memory metadataUri, address to) public override{
        super._safeDynamicMint(to, metadataUri);
    }
}
}
