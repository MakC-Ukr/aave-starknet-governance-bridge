%lang starknet

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


// // Map of queued actions (actionHash => isQueued). Note: actionHash was a (bytes32) in Solidity. 
@storage_var
func _queued_actions(key:felt) -> (res: felt) {
}









// OTHER FUNCTIONS
func _valid(key_len: felt, key: ActionsSet) -> (res: felt) {
    return (3,);
}

func _execute_list{syscall_ptr: felt*}(calls_len: felt, calls: Call*, response: felt*) -> (
    response_len: felt
) {
    return (response_len=2);
}