%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_lt
from contracts.L2.bridge_executor_base_library import BridgeExecutorBaseLibrary
from starkware.starknet.common.syscalls import call_contract
from starkware.cairo.common.alloc import alloc
const MINIMUM_GRACE_PERIOD = 10;  // is equal to 10 minutes in Solidity
const INCREMENT_SELECTOR = 216030643445273762074482936742625134427639679021380938148798651889117677069;
const INCREMENT_BY_SELECTOR = 1372527888969287386569109374288593585984070617352816222675776115507726520402;

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    delay: felt, grace_period: felt, minimum_delay: felt, maximum_delay: felt, guardian: felt
) {
    alloc_locals;
    assert_lt(MINIMUM_GRACE_PERIOD, delay);
    assert_lt(minimum_delay, maximum_delay);
    assert_lt(minimum_delay, delay);
    assert_lt(delay, maximum_delay);

    BridgeExecutorBaseLibrary.update_delay(delay);
    BridgeExecutorBaseLibrary.update_grace_period(grace_period);
    BridgeExecutorBaseLibrary.update_minimum_delay(minimum_delay);
    BridgeExecutorBaseLibrary.update_maximum_delay(maximum_delay);
    BridgeExecutorBaseLibrary.update_guardian(guardian);
    return ();
}

@external
func get_delay{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (res: felt) {
    let res = BridgeExecutorBaseLibrary.get_delay();
    return (res);
}

@external
func get_grace_period{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    res: felt
) {
    let res = BridgeExecutorBaseLibrary.get_grace_period();
    return (res);
}

@external
func get_minimum_delay{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    res: felt
) {
    let res = BridgeExecutorBaseLibrary.get_minimum_delay();
    return (res);
}

@external
func get_maximum_delay{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    res: felt
) {
    let res = BridgeExecutorBaseLibrary.get_maximum_delay();
    return (res);
}
@external
func get_guardian{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    res: felt
) {
    let res = BridgeExecutorBaseLibrary.get_guardian();
    return (res);
}

@external
func set_delay{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(val: felt) -> () {
    let res = BridgeExecutorBaseLibrary.update_delay(val);
    return (res);
}

@external
func set_grace_period{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    val: felt
) -> () {
    let res = BridgeExecutorBaseLibrary.update_grace_period(val);
    return (res);
}

@external
func set_minimum_delay{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    val: felt
) -> () {
    let res = BridgeExecutorBaseLibrary.update_minimum_delay(val);
    return (res);
}

@external
func set_maximum_delay{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    val: felt
) -> () {
    let res = BridgeExecutorBaseLibrary.update_maximum_delay(val);
    return (res);
}

@external
func set_guardian{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(val: felt) -> (
    ) {
    let res = BridgeExecutorBaseLibrary.update_guardian(val);
    return (res);
}

// the following function is currently included for testing purposes only
@external
func _execute_actions_set{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    target: felt, signature: felt, data_len: felt, data: felt*
) -> () {
    BridgeExecutorBaseLibrary._execute_actions_set(target, signature, data_len, data);
    return ();
}

@external
func increase_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    target: felt
) -> () {
    let (data_arr: felt*) = alloc();
    BridgeExecutorBaseLibrary._execute_actions_set(target, INCREMENT_SELECTOR, 0, data_arr);
    return ();
}

@external
func increase_counter_by_val{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    target: felt, by_val: felt
) -> () {
    let (data_arr: felt*) = alloc();
    data_arr[0] = by_val;

    BridgeExecutorBaseLibrary._execute_actions_set(target, INCREMENT_BY_SELECTOR, 1, data_arr);
    return ();
}

@l1_handler
func l1_action_receive{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    from_address: felt, target: felt, signature: felt
) {
    // *logic for checking from_address here*

    let (data_arr: felt*) = alloc();
    assert data_arr[0] = [69];
    let data_len = 0;

    BridgeExecutorBaseLibrary._execute_actions_set(target, signature, data_len, data_arr);
    return ();
}
