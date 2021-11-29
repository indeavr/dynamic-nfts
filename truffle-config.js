const HDWalletProvider = require("@truffle/hdwallet-provider");
const pkey = process.env.PRIVATE_KEY;

module.exports = {
    plugins: [
        'truffle-plugin-verify'
    ],
    // api_keys: {
    // },
    networks: {
        development: {
            host: "127.0.0.1",
            port: 8545,
            network_id: "*",
        },
        test: {
            provider: () => new HDWalletProvider(pkey, process.env.RINKEBY_RPC),
            network_id: 4,
            // confirmations: 10,
            // timeoutBlocks: 200,
            // skipDryRun: true
        },
        // main: {
        //     provider: () => new HDWalletProvider(mnemonic, envConfig.RPC_URL_TEST),
        //     network_id: 56,
        //     confirmations: 10,
        //     timeoutBlocks: 200,
        //     skipDryRun: true
        // },
    },

    // Set default mocha options here, use special reporters etc.
    mocha: {
        timeout: 100000
    },

    // Configure your compilers
    compilers: {
        solc: {
            version: "0.8.10",
            // docker: true,
            settings: {
                optimizer: {
                    enabled: true,
                },
            }
        },
    },
};
