// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/GoldenTicket.sol";
import "../src/attackers/GoldenTicketAttacker.sol";

contract GoldenTicketTest is Test {
    GoldenTicket public target;
    GoldenTicketAttacker public attacker;
    address public player;

    function setUp() public {
        target = new GoldenTicket();
        player = vm.addr(1);
        attacker = new GoldenTicketAttacker(address(target), player);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.label(address(attacker), "Attacker");
    }

    function testGoldenTicket() public {
        vm.startPrank(player, player);

        attacker.attack();

        assertTrue(target.hasTicket(player));

        vm.stopPrank();
    }
}
