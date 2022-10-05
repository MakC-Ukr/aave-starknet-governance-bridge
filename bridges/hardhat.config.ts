import * as dotenv from "dotenv";

import { HardhatUserConfig } from "hardhat/types";
import "@shardlabs/starknet-hardhat-plugin";
import "@nomiclabs/hardhat-ethers";

dotenv.config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const config: HardhatUserConfig = {
  solidity: "0.8.10",
  starknet: {
    venv: "~/cairo_venv",
    network: "devnet",
    wallets: {
      OpenZeppelin: {
          accountName: "OpenZeppelin",
          modulePath: "starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount",
          accountPath: "~/.starknet_accounts"
      }
    }
  },
  networks: {
    devnet: {
        url: "http://127.0.0.1:5050"
    },
    integratedDevnet: {
        url: "http://127.0.0.1:5050"
    },
    hardhat: {}
  },
  mocha: {
    timeout: 1800000,
  },
};

export default config;