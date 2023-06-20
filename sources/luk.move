module yupa::luk{
    //LUK is built to be a stablecoin for the Colombian Peso (COP)
    //This is just an experimental initial version, and will be backed by 1:1
    //COP's
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct LUK has drop{}

    // init function to transfer ownership to package publisher
    fun init(witness: LUK, ctx: &mut TxContext){
        let (treasury_cap, metadata) = coin::create_currency<LUK>(witness, 2, b"LUK", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }


    // owner can mint LUKs
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<LUK>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    // owner can burn LUKs
    public entry fun burn(treasury_cap: &mut TreasuryCap<LUK>, coin: Coin<LUK>) {
        coin::burn(treasury_cap, coin);
    }

    // testing the module init function
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(LUK {}, ctx)
    }
}