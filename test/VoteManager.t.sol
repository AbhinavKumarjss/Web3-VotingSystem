//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Test,console} from "forge-std/Test.sol";
import {VoteManager} from "../src/VoteManager.sol";
import {DeployManager} from "../script/DeployManager.s.sol";

contract TestDeployManager is Test{
    function setUp() public {
     
    }
    function testDeployManager() public {
         DeployManager deployManager = new DeployManager();
        VoteManager voteManager = deployManager.run();
        assertEq(voteManager.getContestants().length, 3);
    }
}
