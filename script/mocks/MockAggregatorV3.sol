// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockAggregatorV3 {
    struct InitData {
        uint8 decimals;
        string description;
        uint256 version;
        uint80 roundId;
        int256 answer;
        uint256 startedAt;
        uint256 updatedAt;
        uint80 answeredInRound;
    }

    InitData private i_initData;

    constructor(InitData memory _initData) {
        i_initData = _initData;
    }

    function decimals() external view returns (uint8) {
        return i_initData.decimals;
    }

    function description() external view returns (string memory) {
        return i_initData.description;
    }

    function version() external view returns (uint256) {
        return i_initData.version;
    }

    function getRoundData(uint80 /*_roundId*/ )
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (
            i_initData.roundId,
            i_initData.answer,
            i_initData.startedAt,
            i_initData.updatedAt,
            i_initData.answeredInRound
        );
    }

    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (
            i_initData.roundId,
            i_initData.answer,
            i_initData.startedAt,
            i_initData.updatedAt,
            i_initData.answeredInRound
        );
    }
}
