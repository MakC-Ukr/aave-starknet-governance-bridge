%lang starknet

struct ActionsSet {
    targets_len: felt,
    targets: felt*,
    
    values_len:felt,
    values: felt*,

    signatures_len:felt,
    signatures: felt*,

    calldatas_len:felt,
    calldatas: felt*,

    withDelegatecalls_len:felt,
    withDelegatecalls: felt*,
    
    executionTime: felt,
    executed: felt,
    canceled: felt,
}

struct User {
    first_name: felt,
    last_name: felt,
}

struct Call {
    to: felt,
    selector: felt,
    calldata_len: felt,
    calldata: felt*,
}