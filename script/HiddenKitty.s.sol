// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/HiddenKitty.sol";
import "../src/attackers/HiddenKittyAttacker.sol";

contract HiddenKittyScript is Script {
    address instanceAddress = 0x9A14cC18383A2e340BCfa8beD4c60962B4E9aB81; // Hardcoded, put your instance address plz
    House target;

    function setUp() public {
        target = House(instanceAddress);
        vm.label(address(target), "Target");
    }

    function run() public {
        vm.startBroadcast();

        new HiddenKittyAttacker(address(target));

        require(target.catFound(), "Challenge incomplete");

        vm.stopBroadcast();
    }
}
