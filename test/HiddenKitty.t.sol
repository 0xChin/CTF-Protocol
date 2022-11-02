// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HiddenKitty.sol";

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

        target.isKittyCatHere(
            keccak256(
                abi.encodePacked(block.timestamp, blockhash(block.number - 69))
            )
        );

        assertTrue(target.catFound());

        vm.stopPrank();
    }
}
