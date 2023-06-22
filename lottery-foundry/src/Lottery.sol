// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {VRFCoordinatorV2Interface} from  "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from  "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
/**
 * @title Lottery
 * @author Neeraj Choubisa
 * @notice A simple lottery contract based on automation and randomness 
 * @dev Implementation of Chainlink VRF and Randomness
 */

contract Lottery is VRFConsumerBaseV2{
    error InvalidTicketPrice(uint ticketPrice, uint requiredTicketPrice,string msg);
    error MaxPlayersExceed(uint players,string msg);
    error Lottery__LotteryNotOpen();
    error Lottery__UpkeepNotNeeded(uint256 _balance, uint256 _players, uint256 _lotteryState);
    uint private constant TICKET_PRICE = 0.1 ether;
    uint private constant MAX_PLAYERS = 100;
    uint private constant INTERVAL = 2 days;
    uint16 private constant CONFIRMATIONS = 2;
    uint32 private constant NUM_WORDS= 3;
    uint private s_lastTimeStamp;
    uint64 private immutable subscriptionId;
    uint32 private immutable callbackGasLimit;
    mapping(address=>bool) private players_entry;
    address private immutable vrfCoordinator;
    address payable[] private players;
    address payable private recentWinner;
    address private owner;
    bytes32 private gasLane;

    LotteryState public lotteryState;
    enum LotteryState {
        OPEN,
        CALCULATING
    }
    event EnterLottery(address indexed player, uint indexed amount);
    event PickedWinner(address indexed winner);
    event RequestedLotteryWinner(uint requestId);
    modifier onlyOwner(){
        require(msg.sender == owner, "Only Owner Can Call This Function");
        _;
    }

    constructor(address _vrfCoordinator,bytes32 _gasLane,uint64 _subscriptionId,uint32 _callbackGasLimit) VRFConsumerBaseV2(_vrfCoordinator){
        s_lastTimeStamp = block.timestamp;
        owner=msg.sender;
        vrfCoordinator=_vrfCoordinator;
        gasLane= _gasLane;
        subscriptionId=_subscriptionId;
        callbackGasLimit=_callbackGasLimit;
        lotteryState = LotteryState.OPEN;
    }


    function receive() external payable {}
    function enterLottery() external payable {
        if((msg.value != TICKET_PRICE)){
            revert InvalidTicketPrice({
                ticketPrice: msg.value,
                requiredTicketPrice: TICKET_PRICE,
                msg:"Give Exact Amount Of Eth"
            });
        }

        if(!(players.length < MAX_PLAYERS)){
            revert MaxPlayersExceed({
                players: players.length,
                msg: "Max Players Exceed"
            });
        }
        if (lotteryState != LotteryState.OPEN) {
            revert Lottery__LotteryNotOpen();
        }
        if((players_entry[msg.sender])){
            revert("You Already Entered The Lottery");
        }

        players_entry[msg.sender]=true;
        players.push(payable(msg.sender));
        emit EnterLottery(msg.sender, msg.value);

    }

    function checkUpkeep(
        bytes memory /* checkData */
    )
        public
        view
        returns (bool upkeepNeeded, bytes memory /* performData */)
    {
        bool isOpen = LotteryState.OPEN == lotteryState;
        bool timePassed = ((block.timestamp - s_lastTimeStamp) > INTERVAL);
        bool hasPlayers = players.length > 0;
        bool hasBalance = address(this).balance > 0;
        upkeepNeeded = (timePassed && isOpen && hasBalance && hasPlayers);
        return (upkeepNeeded, "0x0"); // can we comment this out?
    }
    function performUpkeep(bytes calldata /* performData */) external {
        (bool upkeepNeeded, ) = checkUpkeep("");
        if (!upkeepNeeded) {
            revert Lottery__UpkeepNotNeeded(
                address(this).balance,
                players.length,
                uint256(lotteryState)
            );
        }
        lotteryState = LotteryState.CALCULATING;
        uint256 requestId = VRFCoordinatorV2Interface(vrfCoordinator).requestRandomWords(
            gasLane,
            subscriptionId,
            CONFIRMATIONS,
            callbackGasLimit,
            NUM_WORDS
        );
        emit RequestedLotteryWinner(requestId);
    }

    function fulfillRandomWords(
        uint256 /**_requestId */,
        uint256[] memory _randomWords
    )internal override{
        uint indexOfWinner = _randomWords[0] % players.length;
        //Updating variables to initialState
        lotteryState=LotteryState.OPEN;
        players= new address payable[](0);
        s_lastTimeStamp = block.timestamp;
        address winnerAddress = players[indexOfWinner];
        recentWinner= payable(winnerAddress);
        emit PickedWinner(winnerAddress);
        uint amountTransfer = (address(this).balance) % 80;
        (bool success,)= payable(winnerAddress).call{value:amountTransfer}("");
        require(success,"Transfer Failed");
        payable(owner).transfer(address(this).balance);

    }
    

    // Getter Functions 

    function getTicketPrice() public pure returns(uint) {
        return TICKET_PRICE;
    }

    function getLotteryState() public view returns(uint){
        return uint(lotteryState);
    }

    function getPlayerByIndex(uint idx) public view returns(address){
        return players[idx];
    }

    function getInterval() public view returns(uint){
        return INTERVAL;
    }
}


