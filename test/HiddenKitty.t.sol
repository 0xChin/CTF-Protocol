// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HiddenKitty.sol";
import "../src/attackers/HiddenKittyAttacker.sol";

contract HiddenKittyTest is Test {
    House public target;
    address public player;

    function setUp() public {
        target = new House();
        player = vm.addr(1);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
    }

    function testHiddenKitty() public {
        vm.startPrank(player);

        vm.roll(69); // Avoiding negative overflow

        new HiddenKittyAttacker(address(target));

        assertTrue(target.catFound());

        vm.stopPrank();
    }
}
