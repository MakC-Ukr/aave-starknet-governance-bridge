import { expect } from "chai";
import { network } from "hardhat";
import {
  HttpNetworkConfig,
} from "hardhat/types";

describe("L1-L2 communication test", function () {
    const networkUrl: string = (network.config as HttpNetworkConfig).url;

    it("should deploy the messaging contract", async () => {
        console.log("networkUrl: ", networkUrl);
        expect(networkUrl).not.to.be.undefined;
    });
});