%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.starknet.common.syscalls import (
    call_contract,
)


from src.interfaces.i_executor_base import ActionsSet, User, Call

const MINIMUM_GRACE_PERIOD = 10; // is equal to 10 minutes in Solidity  
// Time between queuing and execution
@storage_var
func _delay() -> (res: felt) {
}
// Time after the execution time during which the actions set can be executed
@storage_var
func _gracePeriod() -> (res: felt) {
}
// Minimum allowed delay
@storage_var
func _minimumDelay() -> (res: felt) {
}
// Maximum allowed delay
@storage_var
func _maximumDelay() -> (res: felt) {
}
// Address with the ability of canceling actions sets
@storage_var
func _guardian() -> (res: felt) {
}
// Number of actions sets
@storage_var
func _actions_set_counter() -> (res: felt) {
}

// Map of registered actions sets (id => ActionsSet)
// func _actionsSets(key: felt) -> (res: ActionsSet) {
@storage_var
func _actionsSets(key: felt) -> (res: felt) {
}
// Map of queued actions (actionHash => isQueued). Note: actionHash was a (bytes32) in Solidity. 
@storage_var
func _queued_actions(key:felt) -> (res: felt) {
}

@storage_var
func contract_nonce() -> (res: felt) {
}


namespace BridgeExecutorBaseLibrary{

    func only_guardian(){
        let (caller) = get_caller_address();
        let (_guardian_addr) = _guardian();
        assert caller = _guardian_addr;
    }

    func update_guardian{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(new_guardian: felt){
        _guardian.write(new_guardian);
        return ();
    }

    func update_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(new_delay: felt){
        _delay.write(new_delay);
        return ();
    }   

    func update_grace_period{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(new_gp: felt){
        _delay.write(new_gp);
        return ();
    }   

    func update_minimum_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(new_md: felt){
        _minimumDelay.write(new_md);
        return ();
    }

    func update_maximum_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(new_md: felt){
        _maximumDelay.write(new_md);
        return ();
    }

    func get_actions_set_example{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(id: felt) -> (res: ActionsSet){
        alloc_locals;
        let (targets_len_) = 2;
        let (targets_) = (61,62);
        let (values_len_) = 2;
        let (values_) = (31,32);
        let (signatures_len_) = 2;
        let (signatures_) = (51,52);
        let (calldatas_len_) = 2;
        let (calldatas_) = (91,92);
        let (withDelegatecalls_len_) = 2;
        let (withDelegatecalls_) = (81,82);

        let actions_set_instance = ActionsSet(
            targets_len = targets_len_,
            targets = targets_,

            values_len = values_len_,
            values =  values_,

            signatures_len = signatures_len_,
            signatures =  signatures_,

            calldatas_len = calldatas_len_,
            calldatas =  calldatas_,

            withDelegatecalls_len = withDelegatecalls_len_,
            withDelegatecalls =  withDelegatecalls_,

            executionTime = 69,
            executed = 0,
            canceled = 0,
        );

        return (actions_set_instance);
    }

    func execute_actions_set{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(
        id: felt // currently unused
    ){
        // let (actions_set) = _actionsSets.read(id);
        let (actions_set : ActionsSet) = get_actions_set_example();
        let (nonce_to_use) = contract_nonce.read();
        // currently supports only single target
        let (res) = _execute_actions_set(
            actions_set.targets[0],
            actions_set.signatures[0],
            actions_set.calldatas_len[0],
            actions_set.calldatas[0],
            // nonce_to_use
        );
        
    }

    func _execute_actions_set{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        target: felt,
        signature: felt,
        data_len: felt, 
        data: felt*,
        // nonce_used: felt,
    ) -> (res: felt){

        let response = call_contract(
            contract_address = target,
            function_selector = signature,
            calldata_size = data_len,
            calldata = data
        );

        return (res = response);
    }

    // syntax for call_contract taken from: https://github.com/Th0rgal/better-multicall/blob/109edc7792e7c22ead3ab5fea7355e9787a70d47/src/normal.cairo
}



// function _executeTransaction(
//     address target,
//     uint256 value,
//     string memory signature,
//     bytes memory data,
//     uint256 executionTime,
//     bool withDelegatecall
//   ) internal returns (bytes memory) {
//     if (address(this).balance < value) revert InsufficientBalance();

//     bytes32 actionHash = keccak256(
//       abi.encode(target, value, signature, data, executionTime, withDelegatecall)
//     );
//     _queuedActions[actionHash] = false;

//     bytes memory callData;
//     if (bytes(signature).length == 0) {
//       callData = data;
//     } else {
//       callData = abi.encodePacked(bytes4(keccak256(bytes(signature))), data);
//     }

//     bool success;
//     bytes memory resultData;
//     if (withDelegatecall) {
//       (success, resultData) = this.executeDelegateCall{value: value}(target, callData);
//     } else {
//       // solium-disable-next-line security/no-call-value
//       (success, resultData) = target.call{value: value}(callData);
//     }
//     return _verifyCallResult(success, resultData);
//   }

