import { Contract } from "ethers";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signers";
import hre, { ethers } from "hardhat";
import chai from "chai";
import { solidity } from "ethereum-waffle";
import envConfig from "../envConfig";

chai.use(solidity);
const { expect } = chai;

describe("Dynamic NFT Tests", function() {
    this.timeout(900000000000);
    let DynamicNft: Contract;
    let owner: SignerWithAddress;
    let gasPrice: any;

    const deploy = async () => {
        const DynamicNftFactory = await ethers.getContractFactory("DynamicNft");
        DynamicNft = await DynamicNftFactory.deploy();
        await DynamicNft.deployed();
        console.log("<<DynamicNft address>>", DynamicNft.address);

        console.log("<<<<< GREAT SUCCESS ! >>>>>");
    }

    beforeEach(async function() {
        [owner] = await ethers.getSigners();
        console.log("<<owner address>>", owner.address);

        await deploy();

        gasPrice = owner.provider?.getGasPrice();
    })

    afterEach(async function() {
        await hre.network.provider.request({
            method: "hardhat_reset",
            params: [{
                forking: {
                    jsonRpcUrl: envConfig.RPC_URL,
                    blockNumber: 13612646,
                },
            }]
        })
    });

    it("Should be able to whitelist", async function() {

    });

});
