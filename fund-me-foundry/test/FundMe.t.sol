// SPDX-License-Identifier: MIT
import "forge-std/Test.sol";
import "../src/FundMe.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract TestFundMe is Test {
    FundMe public fundMe;

    function setUp() public {
        fundMe = new FundMe(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    function testMinimumValue() public {
        uint num = fundMe.MINIMUM_USD();
        assertEq(num, 50 * 10 ** 18);
    }

    function testOwner() public {
        address owner = fundMe.getOwner();
        assertEq(owner, address(this));
    }

    function testVersion() public {
        uint version = fundMe.getVersion();
        console.log("version: %s", version);
        assertEq(version, 4);
    }

    function testFund() public {
        fundMe.fund{value: 30000000000000000}();
        uint amount = fundMe.getAddressToAmountFunded(address(this));
        assertEq(amount, 30000000000000000);
    }

    function testFailFundLowerBalance() public {
        vm.prank(address(1));
        fundMe.fund{value: 20000000000000000}();
        vm.expectRevert(bytes("You need to spend more ETH!"));
    }

    function testGetFunder() public {
        vm.prank(address(1));
        fundMe.fund{value: 30000000000000000}();
        address _addr = fundMe.getFunder(0);
        assertEq(_addr, address(1));
    }

    function testWithdraw() public {
        vm.prank(address(1));
        fundMe.fund{value: 30000000000000000}();
        
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        uint256 endingFundMeBalance = address(fundMe).balance;
        uint256 endingOwnerBalance = fundMe.getOwner().balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(
            startingFundMeBalance + startingOwnerBalance,
            endingOwnerBalance
        );
    }
}
