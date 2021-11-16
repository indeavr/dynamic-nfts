import envConfig from "./envConfig";

import { HardhatUserConfig } from "hardhat/types";

import "@nomiclabs/hardhat-etherscan";
import "hardhat-typechain";
import "@nomiclabs/hardhat-waffle";
import { task } from "hardhat/config";
import "hardhat-gas-reporter";
import 'hardhat-deploy';
import "@nomiclabs/hardhat-ethers";
import * as fs from "fs";
import { HttpNetworkConfig } from "hardhat/src/types/config";
import { isAddress, getAddress, formatUnits, parseUnits } from "ethers/lib/utils";

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (args, hre) => {
    const accounts = await hre.ethers.getSigners();

    for (const account of accounts) {
        console.log(await account.address);
    }
});


console.log("<<< URL >>>", envConfig.RPC_URL);

// const privateKey = new Buffer(envConfig.PRIVATE_KEY, "hex");
const hardhatConfig: HardhatUserConfig = {
    defaultNetwork: "hardhat",
    networks: {
        mainnet: {
            url: envConfig.RPC_URL,
            chainId: 56,
            gasPrice: 5e9,
            accounts: [envConfig.PRIVATE_KEY],
        },
        localhost: {
            url: "http://127.0.0.1:8545"
        },
        hardhat: {
            forking: {
                url: envConfig.RPC_URL,
                blockNumber: 13612646,
            },
            gasPrice: 5e9,
            accounts: [
                { privateKey: envConfig.PRIVATE_KEY, balance: "100000000000000000000000000" },
            ],
            throwOnTransactionFailures: true,
            throwOnCallFailures: true,
            loggingEnabled: true,
        },
        rinkeby: {
            url: `https://rinkeby.infura.io/v3/${envConfig.INFURA_API_KEY}`,
            accounts: [envConfig.PRIVATE_KEY],
        },
        kovan: {
            url: `https://kovan.infura.io/v3/${envConfig.INFURA_API_KEY}`,
            chainId: 97,
            gasPrice: 10000000000,
            accounts: [
                envConfig.PRIVATE_KEY,
            ]
        },
        polytest: {
            url: envConfig.RPC_URL_TEST,
            gasPrice: 1000000000,
            accounts: [
                envConfig.PRIVATE_KEY,
            ]
        },

        matic: {
            url: "https://rpc-mainnet.maticvigil.com/",
            gasPrice: 1000000000,
            accounts: [
                envConfig.PRIVATE_KEY,
            ]
        },
    },
    namedAccounts: {
        deployer: {
            default: 0, // here this will by default take the first account as deployer
            "testnet": 0,
            "mainnet": 0
        },
    },
    solidity: {
        version: "0.8.10",
        settings: {
            optimizer: {
                enabled: true,
                runs: 200
            }
        }
    },
    // paths: {
    //     sources: "./contracts",
    //     tests: "./test",
    //     cache: "./cache",
    //     artifacts: "./deployments"
    // },
    // gasReporter: {
    //     enabled: true,
    //     gasPrice: 10,
    //     showTimeSpent: true
    // }
};

export default hardhatConfig
