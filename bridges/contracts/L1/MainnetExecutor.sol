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