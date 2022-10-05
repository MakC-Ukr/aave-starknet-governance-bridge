import * as dotenv from "dotenv";
require("dotenv").config();
import { HardhatUserConfig } from "hardhat/types";
import "@shardlabs/starknet-hardhat-plugin";
import "@nomiclabs/hardhat-ethers";

dotenv.config();
const { PRIVATE_KEY, ALCHEMY_KEY, HOSTNAME_L1, HOSTNAME_L2 } = process.env;
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const config: HardhatUserConfig = {
  solidity: "0.8.10",
  starknet: {
    venv: "~/cairo_venv",
    network: "l2_testnet",
    wallets: {
      OpenZeppelin: {
          accountName: "OpenZeppelin",
          modulePath: "starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount",
          accountPath: "~/.starknet_accounts"
      }
    }
  },
  networks: {
    l2_testnet: {
      url: `http://${HOSTNAME_L2 || "localhost"}:5050`,
    },
    l1_testnet: {
      url: `http://${HOSTNAME_L1 || "127.0.0.1"}:8545`,
    },
    /* mainnet: {
      url: `https://eth-mainnet.alchemyapi.io/v2/${ALCHEMY_KEY}`,
      accounts: [PRIVATE_KEY],
    }, */
  },
  mocha: {
    timeout: 1800000,
  },
};

export default config;