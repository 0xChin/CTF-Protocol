// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/RootMe.sol";

contract RootMeTest is Test {
    RootMe public target;
    address public player;

    function setUp() public {
        target = new RootMe();
        player = vm.addr(1);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
    }

    function testRootMe() public {
        vm.startPrank(player, player);

        target.register("ROO", "TROOT");
        target.write(bytes32(0), bytes32(abi.encodePacked(uint256(1))));

        assertTrue(target.victory());

        vm.stopPrank();
    }
}
