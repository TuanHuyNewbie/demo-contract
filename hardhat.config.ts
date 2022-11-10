import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-ethers";
let MUMBAI_URL = 'https://eth-goerli.alchemyapi.io/v2/iG49d3KA_RIFihr-hC8883QLfd6GoZ_U';
let MUMBAI_URL1 = 'https://rpc-mumbai.maticvil.com';

let PRIVATE_KEY = '3beb6ff9c3ca25e0f32ca0163bdfac4d1326545f2cbc4d2fe2241f05cd413d32';
//import {}
//require('dotenv').config()
const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  defaultNetwork: "goerli",
  networks: {
    hardhat:{
    },
    goerli: {
      //chainId: 80001,
      url: MUMBAI_URL,
      accounts: [`${PRIVATE_KEY}`]
       
    }
  }
};

export default config;