// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Valve.sol";
import "../src/attackers/ValveAttacker.sol";

contract ValveTest is Test {
    Valve public target;
    Nozzle public attacker;
    address public player;

    function setUp() public {
        target = new Valve();
        player = vm.addr(1);
        attacker = new Nozzle();

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.label(address(attacker), "Attacker");
    }

    function testValve() public {
        vm.startPrank(player);

        attacker.attack{gas: 100000}(target);

        assertTrue(target.open());

        vm.stopPrank();
    }
}
