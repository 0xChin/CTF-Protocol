// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/GoldenTicket.sol";
import "../src/attackers/GoldenTicketAttacker.sol";

contract GoldenTicketTest is Script {
    GoldenTicket public target;
    GoldenTicketAttacker public attacker;
    address instanceAddress = 0xbe15Cd39A79b1DDd8E8deF806B32F14dF29873fc;

    function setUp() public {
        target = GoldenTicket(payable(instanceAddress));
        vm.label(address(target), "Challenge");
    }

    function run() public {
        vm.startBroadcast();

        attacker = new GoldenTicketAttacker(instanceAddress, msg.sender);
        attacker.attack();

        require(target.hasTicket(msg.sender), "Failed");

        vm.stopBroadcast();
    }
}
