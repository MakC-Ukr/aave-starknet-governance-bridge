import { expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Contract, ContractFactory, providers, BigNumber } from "ethers";
import hre, { starknet, network, ethers } from "hardhat";
import {
  StarknetContractFactory,
  StarknetContract,
  HttpNetworkConfig,
  Account,
  StringMap,
} from "hardhat/types";
import { number } from "starknet";

describe("L1-L2 communication test", function () {
    const networkUrl: string = (network.config as HttpNetworkConfig).url;
    let l1user: SignerWithAddress;
    let l1ProxyAdmin: SignerWithAddress;
    let signer: SignerWithAddress;
    let l1Executor: Contract;
    let l2BridgeFactory: StarknetContractFactory;
    let l1ExecutorFactory: ContractFactory;
    let l2Bridge: StarknetContract;
    let l2CounterFactory: StarknetContractFactory;
    let l2Counter: StarknetContract;
    let mockStarknetMessagingAddress: string;

    before(async () => {
        [signer, l1user, l1ProxyAdmin] = await ethers.getSigners();
        l2BridgeFactory = await starknet.getContractFactory(
            "bridge_executor_base"
        );
        l2Bridge = await l2BridgeFactory.deploy({
            "delay":20,
            "grace_period": 10,
            "minimum_delay": 1,
            "maximum_delay": 100,
            "guardian": 1000
        });

        l2CounterFactory = await starknet.getContractFactory("counter_l2");
        l2Counter = await l2CounterFactory.deploy();

        l1ExecutorFactory = await ethers.getContractFactory("MainnetExecutor", signer);
    });

    
    it("base test ", async function () {
        console.log("Hello world");
    });

    it("should deploy the messaging contract", async () => {
        console.log("networkUrl: ", networkUrl);
    //     const { address: deployedTo, l1_provider: L1Provider } =
    //         await starknet.devnet.loadL1MessagingContract(networkUrl);        
    //     expect(deployedTo).not.to.be.undefined;
    //     expect(L1Provider).to.equal(networkUrl);
    //     mockStarknetMessagingAddress = deployedTo;
    //     l1Executor = await l1ExecutorFactory.deploy(
    //         mockStarknetMessagingAddress
    //     );
    //     await l1Executor.deployed();
    });
  

});
