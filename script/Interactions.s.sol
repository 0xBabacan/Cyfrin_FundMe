// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address fundMeContractAddress) public {
        vm.startBroadcast();
        FundMe(payable(fundMeContractAddress)).fund{ value: SEND_VALUE }();
        vm.stopBroadcast();
    }

    function run() external {
        address fundMeContractAddress = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(fundMeContractAddress);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address fundMeContractAddress) public {
        vm.startBroadcast();
        FundMe(payable(fundMeContractAddress)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address fundMeContractAddress = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundMe(fundMeContractAddress);
        vm.stopBroadcast();
    }
}