import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';
import { ethers } from "hardhat";
import { Contract } from "ethers";
import { fromTokenUnitAmount } from "../utils";

let DynamicNft: Contract;
let DyFactory: Contract;

const func: DeployFunction = async function(hre: HardhatRuntimeEnvironment) {
    const liqBnbAmount = fromTokenUnitAmount(1);
    const {
        getNamedAccounts,
        deployments,
        getChainId,
        getUnnamedAccounts,
    } = hre;

    const chainId = await getChainId();
    console.log("Chain ID", chainId);
    const { deployer } = await getNamedAccounts();

    // const DynamicNftFactory = await ethers.getContractFactory("DynamicNft");
    // DynamicNft = await DynamicNftFactory.deploy();
    // await DynamicNft.deployed();
    // console.log("<<DynamicNft address>>", DynamicNft.address);

    const DyNftFactoryFactory = await ethers.getContractFactory("DyNFTFactory");
    DyFactory = await DyNftFactoryFactory.deploy();
    await DyFactory.deployed();
    console.log("<<DyFactory address>>", DyFactory.address);

    console.log("<<<<< GREAT SUCCESS ! >>>>>");
};
export default func;
