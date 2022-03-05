// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

//// Interfaces complete down to ABI, which tells solidity and other languages how 
//// it can interact with another contract

contract FundMe {
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function fund() public payable {
        uint256 minUSD = 50 * 10 ** 18;

        require(getConversion(msg.value) >= minUSD, "spend more!!!");

        // if(getConversion(msg.value) < minUSD) {
        //     revert();
        // }
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        ( , int256 answer, , , )  = priceFeed.latestRoundData();
        return uint256(answer * 1000000000);
    }

    //// 1000000000 WEI = 1 GWEI
    function getConversion(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPriceInWEI = getPrice();
        uint256 ethAmountInUSD = (ethPriceInWEI * ethAmount) / 100000000000000000;
        return ethAmountInUSD; 
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function withdraw() public onlyOwner payable {
        payable(msg.sender).transfer(address(this).balance);
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}
