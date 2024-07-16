// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Bank} from "../src/Bank.sol";
import {Script, console} from "forge-std/Script.sol";
import {Helper} from "./Helper.s.sol";

contract DeployBank is Script {
    function run() public returns (Bank) {
        Helper helper = new Helper();
        vm.startBroadcast();
        Bank bank = new Bank(helper.priceFeed());
        vm.stopBroadcast();
        return bank;
    }
}
