import * as dotenv from "dotenv";

dotenv.config();
const envConfig = {
    INFURA_API_KEY: process.env.INFURA_API_KEY,
    RPC_URL: process.env.RPC_URL,
    PRIVATE_KEY: process.env.PRIVATE_KEY,
    NFT_STORAGE_KEY: process.env.NFT_STORAGE_KEY,
}

export default envConfig;
