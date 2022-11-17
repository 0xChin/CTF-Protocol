// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MetaverseSupermarket.sol";
import "../src/attackers/MetaverseSupermarketAttacker.sol";

contract MetaverseSupermarketTest is Test {
    InflaStore public target;
    MetaverseSupermarketAttacker public attacker;
    address public player;

    function setUp() public {
        target = new InflaStore(player);
        attacker = new MetaverseSupermarketAttacker(address(target));

        player = vm.addr(1);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.label(address(attacker), "Attacker");
    }

    function testMetaverseSupermarket() public {
        vm.startPrank(player, player);

        attacker.attack();

        assertTrue(target.meal().balanceOf(player) >= 10);

        vm.stopPrank();
    }
}
