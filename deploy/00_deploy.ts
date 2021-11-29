import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';
import { ethers } from "hardhat";
import { Contract } from "ethers";
import { fromTokenUnitAmount } from "../utils";

let DynamicNft: Contract;
let DyFactory: Contract;
let MonaUpgrades: Contract;

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

    const MonaUpgradesFactory = await ethers.getContractFactory("MonaUpgrades");
    MonaUpgrades = await MonaUpgradesFactory.deploy();
    await MonaUpgrades.deployed();
    console.log("<<MonaUpgrades address>>", MonaUpgrades.address);

    await (await MonaUpgrades.mintTo("ipfs://bafyreifxnimjiennc3tjz6kamx6azvs5msk6s2gou3qiefns5rvyrnpz3u/metadata.json", "0x32B1Ae6B46B15c305e295767549a9dD984bB6765")).wait(); // ai
    await (await MonaUpgrades.mintTo("ipfs://bafyreiflhdseldsqhtz4r44yezqpwnx5ufenbfzvans2xhblm3wd64c7wq/metadata.json", "0x32B1Ae6B46B15c305e295767549a9dD984bB6765")).wait(); // smth
    await (await MonaUpgrades.mint("ipfs://bafyreib6xtbzb6r6jg4x6fnr6kfuaxah5icuhuzhj3rwfgwuycym54jiby/metadata.json")).wait(); // just
    await (await MonaUpgrades.mint("ipfs://bafyreiatpgdfgj54kienwfcq5ti22iaynguyra4ds5zj53pmx7emcbakf4/metadata.json")).wait(); // vin
    await (await MonaUpgrades.mintTo("ipfs://bafyreifbfx57o7igxxguz57qkolescezh2inbeixrtoxermimwe4oibeue/metadata.json", "0x32B1Ae6B46B15c305e295767549a9dD984bB6765")).wait(); // covid
    await (await MonaUpgrades.mintTo("ipfs://bafyreiavneiwvw57ditrhkfrtc4pq3v47tnjnhqfhizl4qyxycnrffutpy/metadata.json", "0x32B1Ae6B46B15c305e295767549a9dD984bB6765")).wait(); // mr been
    await (await MonaUpgrades.mintTo("ipfs://bafyreih3yz6s3vxb4uwjypsn7pubfvrrcpwjjlfaix2bpahvqaufnwxxzu/metadata.json", "0x32B1Ae6B46B15c305e295767549a9dD984bB6765")).wait(); // patrick
    await (await MonaUpgrades.mintTo("ipfs://bafyreiemct4v4hzh42tfhmryrgda7rl3uq7ymgqlcoepunwdsfjty5ywxu/metadata.json", "0x32B1Ae6B46B15c305e295767549a9dD984bB6765")).wait(); // avatar

    console.log("<<<<< GREAT SUCCESS ! >>>>>");
};
export default func;
