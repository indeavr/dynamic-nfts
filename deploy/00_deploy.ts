import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';
import { ethers } from "hardhat";
import { Contract } from "ethers";
import { fromTokenUnitAmount } from "../utils";

let DynamicNft: Contract;

const func: DeployFunction = async function(hre: HardhatRuntimeEnvironment) {
    const liqBnbAmount = fromTokenUnitAmount(1);
    const {
        getNamedAccounts,
        deployments,
        getChainId,
        getUnnamedAccounts,
    } = hre;

    // return;
    const chainId = await getChainId();
    console.log("Chain ID", chainId);
    const { deployer } = await getNamedAccounts();

    const DynamicNftFactory = await ethers.getContractFactory("DynamicNft");
    DynamicNft = await DynamicNftFactory.deploy();
    await DynamicNft.deployed();
    console.log("<<DynamicNft address>>", DynamicNft.address);

    console.log("<<<<< GREAT SUCCESS ! >>>>>");
};
export default func;