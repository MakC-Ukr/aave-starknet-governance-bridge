%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func value() -> (res: felt) {
}

@constructor
func constructor{
    syscall_ptr: felt*, 
    range_check_ptr,    
    pedersen_ptr: HashBuiltin*
}(){
    value.write(1);
    return();
}

@external 
func increment{
    syscall_ptr: felt*, 
    range_check_ptr,    
    pedersen_ptr: HashBuiltin*
}(){
    let (curr_val) = value.read();
    value.write(curr_val + 1);
    return();
}

@view
func get_val{
    syscall_ptr: felt*, 
    range_check_ptr,    
    pedersen_ptr: HashBuiltin*
}() -> (res:felt){
    let res = value.read();
    return (res);
}
