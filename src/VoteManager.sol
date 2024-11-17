// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/**
 * @dev This contract is used to manage the voting process
 * @author Abhinav Kumar
 * @notice Made during learning process of Solidity
 */
contract VoteManager {
    ////////////////////////////
    //         Errors         //
    ////////////////////////////
    error VoteManager__AlreadyVoted();
    error VoteManager__InvalidContestant();

    ////////////////////////////
    //      Variables         //
    ////////////////////////////

    mapping(address => uint256) private voteCount; // Contestant address => Vote count
    mapping(address => bool) private hasVoted;     // Voter address => Has voted or not
    address[] private contestants;                // List of contestant addresses

    ////////////////////////////
    //      Events            //
    ////////////////////////////

    event Voted(address indexed voter);

    ////////////////////////////
    //      Modifiers         //
    ////////////////////////////

    modifier onlyNewVoter() {
        if (hasVoted[msg.sender]) {
            revert VoteManager__AlreadyVoted();
        }
        _;
    }

    modifier validContestant(address _contestant) {
        if (voteCount[_contestant] == 0 && !_isContestant(_contestant)) {
            revert VoteManager__InvalidContestant();
        }
        _;
    }

    ////////////////////////////
    //      Functions         //
    ////////////////////////////

    constructor(address[] memory _contestants) {
        for (uint256 i = 0; i < _contestants.length; i++) {
            contestants.push(_contestants[i]);
            voteCount[_contestants[i]] = 0;
        }
    }

    function vote(address _contestant) external onlyNewVoter validContestant(_contestant)
    {
        voteCount[_contestant] += 1;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender);
    }

    function getContestants() external view returns (address[] memory) {
        return contestants;
    }

    function hasVoterVoted(address _voter) external view returns (bool) {
        return hasVoted[_voter];
    }

    function getVoteCount(address _contestant) external view returns (uint256) {
        return voteCount[_contestant];
    }

    ////////////////////////////
    //   Internal Functions   //
    ////////////////////////////

    function _isContestant(address _contestant) internal view returns (bool) {
        for (uint256 i = 0; i < contestants.length; i++) {
            if (contestants[i] == _contestant) {
                return true;
            }
        }
        return false;
    }
}
