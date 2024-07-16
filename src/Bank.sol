// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
/**
 * @title Bank
 * @author sharathkrml
 * @notice this contract lets user deposit and withdraw funds with respect to dollar
 */

contract Bank {
    mapping(address user => uint256 balance) private s_accounts;

    AggregatorV3Interface private i_priceFeed;

    event Deposit(address indexed user, uint256 amount);

    error Bank__InsufficientBalance();
    error Bank__TransferFailed();

    constructor(address _priceFeed) {
        i_priceFeed = AggregatorV3Interface(_priceFeed);
    }

    /**
     * @notice deposit funds to the account
     */
    function deposit() external payable {
        s_accounts[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function balanceOf(address _user) external view returns (uint256) {
        return s_accounts[_user];
    }

    // /**
    //  * @notice withdraw funds from the account
    //  * @param _amountInUSD amount to withdraw in USD
    //  */
    function withdraw(uint256 _amountInUSD) external {
        uint256 _amount = getEquivalentWeiForUSD(_amountInUSD);
        if (s_accounts[msg.sender] < _amount) {
            revert Bank__InsufficientBalance();
        }
        s_accounts[msg.sender] -= _amount;
        (bool success,) = msg.sender.call{value: _amount}("");
        if (!success) {
            revert Bank__TransferFailed();
        }
    }
    /**
     * @notice get equivalent wei for the given USD amount
     * @param _amountInUSD amount in USD
     * Price feed gives you price of (10^priceFeedDecimals) ether in USD
     * @return equivalent wei
     */
    function getEquivalentWeiForUSD(uint256 _amountInUSD) public view returns (uint256) {
        uint8 priceFeedDecimals = i_priceFeed.decimals();
        (, int256 price,,,) = i_priceFeed.latestRoundData();
        return _amountInUSD * 10 ** priceFeedDecimals * 10 ** 18 / uint256(price);
    }
}
