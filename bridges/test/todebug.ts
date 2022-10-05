import { expect } from "chai";
import { network, starknet } from "hardhat";
import {
  HttpNetworkConfig,
} from "hardhat/types";

describe("L1-L2 communication test", function () {
    
    it("should get network url", async () => {
        console.log("network.config:", network.config);
        const networkUrl: string = (network.config as HttpNetworkConfig).url;
        console.log("networkUrl: ", networkUrl);
        expect(networkUrl).not.to.be.undefined;
    });

    // it("loadL1MessagingContract should work", async () => {
    //     const { address: deployedTo, l1_provider: L1Provider } =
    //         await starknet.devnet.loadL1MessagingContract(networkUrl);        
    // });
});