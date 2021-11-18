import * as dotenv from "dotenv";

dotenv.config();
const envConfig = {
    INFURA_API_KEY: process.env.INFURA_API_KEY,
    RPC_URL: process.env.RPC_URL,
    RPC_URL_TEST: process.env.RPC_URL_TEST,
    PRIVATE_KEY: process.env.PRIVATE_KEY,
    NFT_STORAGE_KEY: process.env.NFT_STORAGE_KEY,
    POLYSCAN_KEY: process.env.POLYSCAN_KEY,
}

export default envConfig;
