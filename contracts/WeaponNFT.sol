pragma solidity 0.8.10;

import "./lib/DynamicNFTFactory.sol";

contract WeaponNFTFactory is DynamicNFTFactory {
    string[] public meta;

    struct Weapon {
        uint level;
        uint damage;
        uint agility;
    }

    mapping(uint => Weapon) public weapons;

    constructor() ERC721("WeaponNFTFactory", "DynamicWeaponNFTFactory"){
        meta.push("");
        meta.push("ipfs://QmbmFeLvymjNYyuS3xHfBvyAHtD3vrKp7NdLWsJpRM91bm");
        meta.push("ipfs://QmXcAFAF9zvxnAjdjxaPKpUge9LBPWhiYsTtDWxGndtxJC");
        meta.push("ipfs://QmW9vC4CZP3XfZwHcaDcFJ4amWP8HLHfHXWQQiLEakfW5A");
        meta.push("ipfs://QmNQYgLUEqimdSfBdMRzom9pedMEUSvyLShK16c8uF3NhU");
    }

    function mint(string memory metadataUri) public override {
        require(canMint(msg.sender), "Cant Mint !");

        uint tokenId = super._safeDynamicMint(msg.sender, meta[1]);

        weapons[tokenId] = Weapon(1, 10, 10);
    }

    function evolve(uint tokenId) public{
        weapons[tokenId].level = 3;
        weapons[tokenId].damage = 300;
        weapons[tokenId].level = 300;
    }

    function refresh(uint tokenId) public{
        uint level = weapons[tokenId].level;

        setTokenURI(tokenId, meta[level]);
    }
}
