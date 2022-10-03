%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin


@contract_interface
namespace BridgeExecutorBase {
    
}


@external
func test_deploy{
    syscall_ptr: felt*, 
    range_check_ptr,    
    pedersen_ptr: HashBuiltin*
}() {
    alloc_locals;
    local contract_address: felt;
    %{ ids.contract_address = deploy_contract("./src/bridge_executor_base.cairo", [20,10,1,100,1000]).contract_address %}
    return ();
}