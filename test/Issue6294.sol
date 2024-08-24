pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract MyObject is Ownable, UUPSUpgradeable, Initializable {
    constructor() {
        _disableInitializers();
    }

    function initialize(address anOwner) public virtual initializer {
        _transferOwnership(anOwner);
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}

contract TestProxy is Test {
    MyObject singleton = new MyObject();

    function setUp() public {
        //with this line enabled, the test revert. comment this line, and the test will pass
        vm.pauseGasMetering();
    }

    function newObj(address owner, uint256 salt) internal returns (MyObject) {
        return
            MyObject(
                address(
                    new ERC1967Proxy{salt: bytes32(salt)}(
                        address(singleton),
                        abi.encodeCall(MyObject.initialize, (owner))
                    )
                )
            );
    }

    function test_send1() public {
        MyObject obj = newObj(msg.sender, 0);
        vm.resumeGasMetering();
        //this is the method we want to test (and meter for gas)
        obj.owner();
    }
}
