%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
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
// @storage_var
// func _actionsSets(key: felt) -> (res: ActionsSet) {
// }
// Map of queued actions (actionHash => isQueued). Note: actionHash was a (bytes32) in Solidity. 
@storage_var
func _queued_actions(key:felt) -> (res: felt) {
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
}