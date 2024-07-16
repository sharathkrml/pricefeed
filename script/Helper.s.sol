// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MockAggregatorV3} from "./mocks/MockAggregatorV3.sol";

contract Helper is Script {
    address public priceFeed;

    constructor() {
        if (block.chainid == 31337) {
            console.log("Deploying on local network");
            priceFeed = getAnvilPriceFeed();
        } else {
            console.log("Deploying on mainnet");
        }
    }

    function getAnvilPriceFeed() public returns (address) {
        MockAggregatorV3.InitData memory initData = MockAggregatorV3.InitData({
            decimals: 8,
            description: "ETH / USD",
            version: 4,
            roundId: 18446744073709565753,
            answer: 342278119000,
            startedAt: 1720675236,
            updatedAt: 1720675236,
            answeredInRound: 18446744073709565753
        });
        vm.startBroadcast();
        MockAggregatorV3 aggregator = new MockAggregatorV3(initData);
        vm.stopBroadcast();
        return address(aggregator);
    }
}
