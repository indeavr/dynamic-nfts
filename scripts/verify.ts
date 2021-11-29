//Submit Source Code for Verification
import { readFileSync } from "fs";
import axios from "axios";
import envConfig from "../envConfig";

const api_key = envConfig.POLYSCAN_KEY;

const verify = async () => {
    // const filePath = path.resolve(__dirname, "./deploy_addr.json")
    //
    // const db: any = await new Promise((resolve, reject) => {
    //     fs.readFile(filePath, 'utf-8', (err, data) => {
    //         if (err) {
    //             reject(err);
    //         }
    //         const addrs = JSON.parse(data.toString());
    //         resolve(addrs);
    //     });
    // });

    const info = [
        {
            address: "", name: "", ctor: [],
            file: readFileSync(__dirname + '../contracts/', "utf-8")
        },
    ]

    await new Promise(resolve => setTimeout(resolve, 2000));
    info.forEach((obj, i) => {
        const name = obj.name;
        const file = obj.file;
        const address = obj.address;
        const ctor = obj.ctor;
        const verify = {
            apikey: api_key,                     //A valid API-Key is required
            module: 'contract',                             //Do not change
            action: 'verifysourcecode',                     //Do not change
            contractaddress: address,   //Contract Address starts with 0x...
            sourceCode: file,             //Contract Source Code (Flattened if necessary)
            contractname: name,         //ContractName (if codeformat=solidity-standard-json-input, then enter contractname as ex: erc20.sol:erc20)
            compilerversion: "v0.8.10...",   // see https://BscScan.com/solcversions for list of support versions
            optimizationUsed: 1, //0 = No Optimization, 1 = Optimization used (applicable when codeformat=solidity-single-file)
            runs: 500,                                      //set to 200 as default unless otherwise  (applicable when codeformat=solidity-single-file)
            licenseType: 1,           //Valid codes 1-12 where 1=No License .. 12=Apache 2.0, see https://BscScan.com/contract-license-types
            constructorArguments: ctor
        }


        axios.post("https://api-testnet.bscscan.com/api", verify,
                { headers: { 'Content-Type': "application/x-www-form-urlencoded" } }
            )
            .then((result) => {
                console.log("response status: " + result.statusText);
                console.log("response keys: ", Object.keys(result.data));
                console.log("status : " + result.data.status);
                console.log("message : " + result.data.message);
                console.log("result : " + result.data.result);
                console.log("status again : " + result?.status);
            })
            .catch((result) => {
                console.log("error!", result);
            });
    });

}

verify();

