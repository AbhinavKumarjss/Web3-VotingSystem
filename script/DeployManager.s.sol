//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/Test.sol";
import {VoteManager} from "../src/VoteManager.sol";

contract DeployManager is Script {
    function run() external returns (VoteManager) {
        address[] memory contestants;
        contestants = new address[](3);
        contestants[0] = address(0);
        contestants[1] = address(1);
        contestants[2] = address(2);

        vm.startBroadcast();
        VoteManager voteManager = new VoteManager(contestants);
        vm.stopBroadcast();
        return voteManager;
    }
}
