import { expect } from "chai";
import { network, starknet } from "hardhat";
import {
  HttpNetworkConfig,
} from "hardhat/types";

describe("L1-L2 communication test", function () {
    // const networkUrl: string = "localhost:8545/";
    const networkUrl: string = (network.config as HttpNetworkConfig).url;
    
    it("should get network url", async () => {
        console.log("networkUrl: ", networkUrl);
        expect(networkUrl).not.to.be.undefined;
    });

    it("loadL1MessagingContract should work", async () => {
      // const networkUrl: string = (network.config as HttpNetworkConfig).url;
        const { address: deployedTo, l1_provider: L1Provider } =
            await starknet.devnet.loadL1MessagingContract(networkUrl);        
    });
});