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
func _grace_period() -> (res: felt) {
}
// Minimum allowed delay
@storage_var
func _minimum_delay() -> (res: felt) {
}
// Maximum allowed delay
@storage_var
func _maximum_delay() -> (res: felt) {
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

    func get_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }() -> (res:felt){
        let res = _delay.read();
        return (res);
    }

    func get_grace_period{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }() -> (res:felt){
        let res = _grace_period.read();
        return (res);
    }
    func get_minimum_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }() -> (res:felt){
        let res = _minimum_delay.read();
        return (res);
    }
    func get_maximum_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }() -> (res:felt){
        let res = _maximum_delay.read();
        return (res);
    }
    func get_guardian{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }() -> (res:felt){
        let res = _guardian.read();
        return (res);
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
        _grace_period.write(new_gp);
        return ();
    }   

    func update_minimum_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(new_md: felt){
        _minimum_delay.write(new_md);
        return ();
    }

    func update_maximum_delay{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(new_md: felt){
        _maximum_delay.write(new_md);
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
        data: felt*
    ) -> (){
        call_contract(
            contract_address = target,
            function_selector = signature,
            calldata_size = data_len,
            calldata = data
        );
        // syntax for call_contract taken from: https://github.com/Th0rgal/better-multicall/blob/109edc7792e7c22ead3ab5fea7355e9787a70d47/src/normal.cairo
        return ();
    }

    func cancel{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        id: felt
    ){
        // let (actions_set) = _actionsSets.read(id);
        let (actions_set : ActionsSet) = get_actions_set_example();
        assert actions_set.executed = 0;
        assert actions_set.canceled = 0; // this would probably fail though
        // _actionsSets.write(id, actions_set);
    }

    func _queue{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        targets_len: felt,
        targets: felt*,
        
        values_len:felt,
        values: felt*,

        signatures_len:felt,
        signatures: felt*,

        calldatas_len:felt,
        calldatas: felt*,

        withDelegatecalls_len:felt,
        withDelegatecalls: felt*
    ) -> (res: felt){
        let (new_id) = _actions_set_counter.read();
        _actions_set_counter.write(new_id+1);
        let (exec_time) = 69;

        let actions_set_instance = ActionsSet(
            targets_len = targets_len,
            targets = targets,

            values_len = values_len,
            values =  values,

            signatures_len = signatures_len,
            signatures =  signatures,

            calldatas_len = calldatas_len,
            calldatas =  calldatas,

            withDelegatecalls_len = withDelegatecalls_len,
            withDelegatecalls =  withDelegatecalls,

            executionTime = exec_time,
            executed = 0,
            canceled = 0,
        );
        
        // _actionsSets.write(new_id, actions_set_instance);
    }

}