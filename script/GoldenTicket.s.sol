// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/GoldenTicket.sol";
import "../src/attackers/GoldenTicketAttacker.sol";

contract GoldenTicketTest is Script {
    GoldenTicket public target;
    GoldenTicketAttacker public attacker;
    address instanceAddress = 0x97f72549791A0b96Bc35435d86e0FA908A9D1d37;

    function setUp() public {
        target = GoldenTicket(payable(instanceAddress));
        vm.label(address(target), "Challenge");
    }

    function run() public {
        vm.startBroadcast();

        attacker = new GoldenTicketAttacker(
            instanceAddress,
            0x6864dC5998c25Db320D3370A53592E44a246FFf4
        );
        attacker.attack();

        require(
            target.hasTicket(0x6864dC5998c25Db320D3370A53592E44a246FFf4),
            "Failed"
        );

        vm.stopBroadcast();
    }
}
