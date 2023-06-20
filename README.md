# coins

Main repo for creating the involved coins in the Yupa ecosystem.

## How to deploy the package

---

First, make sure you have the SUI CLI installed.

Then, run in your terminal:

```
sui client publish ./sources/luk.move --gas-budget 1000000000
```

Then look for the first immmutable object created as a result of the transaction and copy that ID. That ID is the ID of the package object. Then look for the TreasuryCap object ID (you can use `sui objects --json` for that)

Then run:

```
sui client call --function mint --module luk --package <packageID> —args <treasuryCapID> <amount> <addressToBeMinted> --gas-budget 1000000000
```

Be sure to always have gas objects available
