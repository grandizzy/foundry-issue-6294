```
forge test --mt test_send1 -vvvv
[⠒] Compiling...
No files changed, compilation skipped

Ran 1 test for test/Issue6294.sol:TestProxy
[PASS] test_send1() (gas: 1252)
Traces:
  [1252] TestProxy::test_send1()
    ├─ [35400] → new ERC1967Proxy@0xf4c9B03b443c0a756AEa41580db80Ba3705F3A51
    │   ├─ emit Upgraded(implementation: MyObject: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ [0] MyObject::initialize(DefaultSender: [0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38]) [delegatecall]
    │   │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: DefaultSender: [0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38])
    │   │   ├─ emit Initialized(version: 1)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 177 bytes of code
    ├─ [0] VM::resumeGasMetering()
    │   └─ ← [Return] 
    ├─ [718] ERC1967Proxy::owner() [staticcall]
    │   ├─ [323] MyObject::owner() [delegatecall]
    │   │   └─ ← [Return] DefaultSender: [0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38]
    │   └─ ← [Return] DefaultSender: [0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38]
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 2.29ms (800.78µs CPU time)

Ran 1 test suite in 1.50s (2.29ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```
