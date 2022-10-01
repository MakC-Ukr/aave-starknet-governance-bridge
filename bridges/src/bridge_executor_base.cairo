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

    BridgeExecutorBaseLibrary.update_guardian(guardian);
    BridgeExecutorBaseLibrary.update_delay(delay);
    BridgeExecutorBaseLibrary.update_grace_period(grace_period);
    BridgeExecutorBaseLibrary.update_minimum_delay(minimum_delay);
    BridgeExecutorBaseLibrary.update_maximum_delay(maximum_delay);
    return ();
}