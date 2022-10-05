// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./IStarknetCore.sol";

/**
  *  MainnetExecutor is the governance contract that will send a message to L2.
  *  The execute() function will send the details for the transactoin that must be create on StarkNet.
  *  For testing purposes, a mock transaction is created below that shall increment the counter for Counter.cairo contract on StarkNet
*/

contract MainnetExecutor{
    IStarknetCore private starknetCore;
    uint INCREMENT_SELECTOR = 216030643445273762074482936742625134427639679021380938148798651889117677069;
    uint INCREMENT_BY_SELECTOR = 1372527888969287386569109374288593585984070617352816222675776115507726520402;
    constructor(address starknetCore_){
        starknetCore = IStarknetCore(starknetCore_);
    }

    function execute_inc(uint l2Evaluator) public{
        uint256[] memory payload = new uint256[](0);
        starknetCore.sendMessageToL2(l2Evaluator, INCREMENT_SELECTOR, payload);
    }
}

// pragma solidity 0.8.10;

// import {IStarknetMessaging} from "./IStarknetMessaging.sol";

// contract Executor {
//     IStarknetMessaging public _messagingContract;
//     uint256 public _targetContractAddress;
//     uint256 public _l2Bridge;
//     /**
//         @notice bridge constructor
//         @param messagingContract address of the messaging contract
//      */
//     constructor(
//         address messagingContract,
//         uint256 l2Bridge,
//         uint256 targetContractAddress
//     ) {
//         _l2Bridge = l2Bridge;
//         _targetContractAddress = targetContractAddress;
//         _messagingContract = IStarknetMessaging(messagingContract);
//     }

//     function setCounter(uint128 counter) public {
//         uint256[] memory payload = new uint256[](3);
//         payload[0] = _targetContractAddress; //target contract address
//         _messagingContract.sendMessageToL2(
//             _l2Bridge,
//             COUNTER_SELECTOR,
//             payload
//         );
//     }
// }