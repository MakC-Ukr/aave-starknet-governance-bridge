%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc

@contract_interface
namespace Counter {
    func increment() {
    }
    func increment_by(by_val: felt) {
    }
    func get_val() -> (res: felt) {
    }
}

@contract_interface
namespace BridgeExecutorBase {
    func get_delay() -> (res: felt) {
    }
    func get_grace_period() -> (res: felt) {
    }
    func get_minimum_delay() -> (res: felt) {
    }
    func get_maximum_delay() -> (res: felt) {
    }
    func get_guardian() -> (res: felt) {
    }
    func set_delay(val: felt) -> () {
    }
    func set_grace_period(val: felt) -> () {
    }
    func set_minimum_delay(val: felt) -> () {
    }
    func set_maximum_delay(val: felt) -> () {
    }
    func set_guardian(val: felt) -> () {
    }
    func _execute_actions_set(target: felt, signature: felt, data_len: felt, data: felt*) -> () {
    }
    func increase_counter(target: felt) -> () {
    }
    func increase_counter_by_val(target: felt, by_val: felt) -> () {
    }
}

@external
func __setup__() {
    %{ context.bridge_address = deploy_contract("./contracts/L2/bridge_executor_base.cairo", [20,10,1,100,1000]).contract_address %}
    %{ context.counter_address = deploy_contract("./contracts/L2/counter.cairo", []).contract_address %}
    return ();
}

@external
func test_deploy{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    alloc_locals;
    %{ print("Hello world. Deployment succesful") %}
    return ();
}

@external
func test_getters{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    alloc_locals;
    local bridge_address;
    %{ ids.bridge_address = context.bridge_address; %}

    let (delay) = BridgeExecutorBase.get_delay(bridge_address);
    assert delay = 20;
    let (grace_period) = BridgeExecutorBase.get_grace_period(bridge_address);
    assert grace_period = 10;
    let (minimum_delay) = BridgeExecutorBase.get_minimum_delay(bridge_address);
    assert minimum_delay = 1;
    let (maximum_delay) = BridgeExecutorBase.get_maximum_delay(bridge_address);
    assert maximum_delay = 100;
    let (guardian) = BridgeExecutorBase.get_guardian(bridge_address);
    assert guardian = 1000;
    return ();
}

@external
func test_setters{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    alloc_locals;
    local bridge_address;
    %{ ids.bridge_address = context.bridge_address; %}

    BridgeExecutorBase.set_delay(bridge_address, 33);
    let (delay) = BridgeExecutorBase.get_delay(bridge_address);
    assert delay = 33;
    BridgeExecutorBase.set_grace_period(bridge_address, 33);
    let (grace_period) = BridgeExecutorBase.get_grace_period(bridge_address);
    assert grace_period = 33;
    BridgeExecutorBase.set_minimum_delay(bridge_address, 33);
    let (minimum_delay) = BridgeExecutorBase.get_minimum_delay(bridge_address);
    assert minimum_delay = 33;
    BridgeExecutorBase.set_maximum_delay(bridge_address, 33);
    let (maximum_delay) = BridgeExecutorBase.get_maximum_delay(bridge_address);
    assert maximum_delay = 33;
    BridgeExecutorBase.set_guardian(bridge_address, 33);
    let (guardian) = BridgeExecutorBase.get_guardian(bridge_address);
    assert guardian = 33;
    return ();
}

@external
func test_call_contract{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    alloc_locals;
    local bridge_address;
    local counter_address;

    %{
        ids.bridge_address = context.bridge_address;
        ids.counter_address = context.counter_address;
    %}

    let (val_old) = Counter.get_val(counter_address);
    assert val_old = 1;

    BridgeExecutorBase.increase_counter(bridge_address, counter_address);

    let (val_new) = Counter.get_val(counter_address);
    assert val_new = 2;  // 1+1

    return ();
}

@external
func test_call_contract_with_param{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}(
    ) {
    alloc_locals;
    local bridge_address;
    local counter_address;
    local by_val = 69;

    %{
        ids.bridge_address = context.bridge_address;
        ids.counter_address = context.counter_address;
    %}

    let (val_old) = Counter.get_val(counter_address);
    assert val_old = 1;

    BridgeExecutorBase.increase_counter_by_val(bridge_address, counter_address, by_val);

    let (val_new) = Counter.get_val(counter_address);
    assert val_new = 70;  // 1+69

    return ();
}
