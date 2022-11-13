// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Mothership.sol";
import "../src/attackers/MothershipAttacker.sol";

contract MothershipTest is Test {
    Mothership public target;
    address public player;
    MothershipAttacker public attacker;

    function setUp() public {
        target = new Mothership();
        player = vm.addr(1);
        attacker = new MothershipAttacker(address(target));

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.label(address(attacker), "Attacker");
    }

    function testMothership() public {
        vm.startPrank(player);

        attacker.attack();

        assertTrue(target.hacked());

        vm.stopPrank();
    }
}
