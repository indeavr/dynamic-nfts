import { NFTStorage, File } from 'nft.storage'
import * as fs from "fs";
import * as path from "path";
import envConfig from "../envConfig";

const apiKey = envConfig.NFT_STORAGE_KEY
const client = new NFTStorage({ token: apiKey });

function ArrayBufferToBinary(buffer) {
    let uint8 = new Uint8Array(buffer);
    return uint8.reduce((binary, uint8) => binary + uint8.toString(2), "");
}

const b64toBlob = (b64Data, contentType = '', sliceSize = 512): Blob => {
    const byteCharacters = Buffer.from(b64Data, 'base64').toString('binary');
    const byteArrays = [];

    for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) {
        const slice = byteCharacters.slice(offset, offset + sliceSize);

        const byteNumbers = new Array(slice.length);
        for (let i = 0; i < slice.length; i++) {
            byteNumbers[i] = slice.charCodeAt(i);
        }

        const byteArray = new Uint8Array(byteNumbers);
        byteArrays.push(byteArray);
    }

    const blob = new Blob(byteArrays, { type: contentType });
    return blob;
}

const toBlob = (arraybuffer) => {
    let buffer = Buffer.from(arraybuffer);
    let binary = Uint8Array.from(buffer).buffer;
    return binary
}

const readFile = async (path: string) => {
    const fileContent: any = await new Promise((resolve, reject) => {
        fs.readFile(path, (err, data) => {
            if (err) {
                reject(err);
            }
            resolve(data);
        });
    });

    return fileContent;
}

const getImg = async (): Promise<string> => {
    // preliminary code to handle getting local file and finally printing to console
    // the results of our function ArrayBufferToBinary().
    let file = await readFile(path.resolve(__dirname, "./files/img.jpg"));
    // const base = Buffer.from(file).toString('base64');

    return file;
    // let reader = new FileReader();
    //
    // return new Promise((resolve) => {
    //     reader.onload = function(event) {
    //         let data = event.target.result;
    //         const binaryData = ArrayBufferToBinary(data);
    //         console.log(binaryData);
    //         console.log(binaryData);
    //         const blob = new Blob(binaryData, "jpg")
    //         resolve(binaryData);
    //     };
    //     reader.readAsArrayBuffer(file); //gets an ArrayBuffer of the file
    // })
}

(async function() {
    const filePath = path.resolve(__dirname, "./files/test.json")

    const fileContent: any = await new Promise((resolve, reject) => {
        fs.readFile(filePath, 'utf-8', (err, data) => {
            if (err) {
                reject(err);
            }
            const addrs = JSON.parse(data.toString());
            resolve(addrs);
        });
    });

// const metadata = await client.store({
//     name: 'Pinpie',
//     description: 'Pin is not delicious beef!',
//     image: new File([/* data */], 'pinpie.jpg', { type: 'image/jpg' })
// })

    const imgFile: string = await getImg();
    // const blob = await toBlob(imgFile);
    // console.log("Binary", img);

    const file = new File([imgFile], 'image.jpg', { type: 'image/jpg' });
    console.log(file);

    const metadata = await client.store({
        ...fileContent,
        image: file
    })

    console.log("file", metadata.url)
})();
