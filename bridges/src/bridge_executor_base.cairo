%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (assert_lt)
from src.bridge_executor_base_library import BridgeExecutorBaseLibrary

const MINIMUM_GRACE_PERIOD = 10; // is equal to 10 minutes in Solidity  

@constructor
func constructor{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(
    delay: felt,
    grace_period: felt,
    minimum_delay: felt,
    maximum_delay: felt,
    guardian: felt
){
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
func get_delay{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt){
    let res = BridgeExecutorBaseLibrary.get_delay();
    return (res);
}

@external
func get_grace_period{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt){
    let res = BridgeExecutorBaseLibrary.get_grace_period();
    return (res);
}

@external
func get_minimum_delay{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt){
    let res = BridgeExecutorBaseLibrary.get_minimum_delay();
    return (res);
}

@external
func get_maximum_delay{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt){
    let res = BridgeExecutorBaseLibrary.get_maximum_delay();
    return (res);
}
@external
func get_guardian{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt){
    let res = BridgeExecutorBaseLibrary.get_guardian();
    return (res);
}

@external
func set_delay{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(val:felt) -> (){
    let res = BridgeExecutorBaseLibrary.update_delay(val);
    return (res);
}

@external
func set_grace_period{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(val:felt) -> (){
    let res = BridgeExecutorBaseLibrary.update_grace_period(val);
    return (res);
}

@external
func set_minimum_delay{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(val:felt) -> (){
    let res = BridgeExecutorBaseLibrary.update_minimum_delay(val);
    return (res);
}

@external
func set_maximum_delay{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(val:felt) -> (){
    let res = BridgeExecutorBaseLibrary.update_maximum_delay(val);
    return (res);
}

@external
func set_guardian{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(val:felt) -> (){
    let res = BridgeExecutorBaseLibrary.update_guardian(val);
    return (res);
}

// the following function is currently included for testing purposes only
@external
func _execute_actions_set{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(
    target: felt,
    signature: felt,
    data_len: felt, 
    data: felt*,
) -> (){
    BridgeExecutorBaseLibrary._execute_actions_set(target, signature, data_len, data);
    return ();
}