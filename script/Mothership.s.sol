// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Mothership.sol";
import "../src/attackers/MothershipAttacker.sol";

contract MothershipTest is Script {
    Mothership public target;
    MothershipAttacker public attacker;
    address instanceAddress = 0x755af5675fd86D824E7405b952164F3bdc4B009E;

    function setUp() public {
        target = Mothership(payable(instanceAddress));
        vm.label(address(target), "Challenge");
    }

    function run() public {
        vm.startBroadcast();

        attacker = new MothershipAttacker(instanceAddress);
        attacker.attack();

        vm.stopBroadcast();
    }
}
