// SPDX-License-Identifier: MIT
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
pragma solidity ^0.8.18;
library PriceConvertor {

    function getPriceInUsed() internal view returns (uint) {
            AggregatorV3Interface   dataFeed;

         dataFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
         (,int256 answer,,,) = dataFeed.latestRoundData();
         return uint(answer * 1e10);
    }
    function getConversionRate(uint amount) internal view returns (uint) {
        uint ethPrice = getPriceInUsed();
        return (ethPrice * amount) / 1e18;
    }
    function getVersion() internal view returns(uint){
            AggregatorV3Interface  dataFeed;

         dataFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
         return dataFeed.version();
    }
}