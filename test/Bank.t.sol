// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {Bank} from "../src/Bank.sol";
import {DeployBank} from "../script/DeployBank.s.sol";

contract BankTest is Test {
    // redeclared event Deposit(address indexed user, uint256 amount);
    event Deposit(address indexed user, uint256 amount);

    DeployBank public deployBank;
    Bank public bank;

    function setUp() public {
        deployBank = new DeployBank();
        bank = deployBank.run();
        console.log("bank: ", address(bank));
    }

    // function test_Deposit() public {
    //     vm.expectEmit(true, false, false, true, address(bank));
    //     emit Deposit(address(this), 100);
    //     bank.deposit{value: 100}();
    //     assertEq(bank.balanceOf(address(this)), 100);
    // }

    function test_getEquivalentWei() public view {
        int256 weth = bank.getEquivalentWeiForUSD(342278119000);
        assertEq(weth, 10 ** 8 * 10 ** 18);
    }
}
