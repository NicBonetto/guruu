pragma solidity ^0.4.18;

contract Polls {
    struct Poll {
        bytes32 title;
        bytes32 option1;
        bytes32 option2;
        uint count1;
        uint count2;
        bool exists;
    }

    mapping (bytes32 => Poll) public polls;

    function createPoll (bytes32 _name, bytes32 _option1, bytes32 _option2) public {
        Poll memory newPoll;

        newPoll.title = _name;
        newPoll.option1 = _option1;
        newPoll.option2 = _option2;
        newPoll.count1 = 0;
        newPoll.count2 = 0;
        newPoll.exists = true;

        polls[newPoll.title] = newPoll;
    }

    function vote (bytes32 optionName, bytes32 pollName) public {
        require(doesPollExist(pollName));

        if (polls[pollName].option1 == optionName) {
            polls[pollName].count1 += 1;
        } else {
            polls[pollName].count2 += 1;
        }
    }

    function getPollName (bytes32 pollName) public view returns (bytes32) {
        require(doesPollExist(pollName));

        return polls[pollName].title;
    }

    function getPollOptions (bytes32 pollName) public view returns (bytes32[] options) {
        require(doesPollExist(pollName));
 
        options[0] = polls[pollName].option1;
        options[1] = polls[pollName].option2;

        return options;
    }

    function getPollCounts (bytes32 pollName) public view returns (uint[] counts) {
        require(doesPollExist(pollName));

        counts[0] = polls[pollName].count1;
        counts[1] = polls[pollName].count2;

        return counts;
    }

    function doesPollExist (bytes32 pollName) private view returns (bool) {
        if (polls[pollName].exists) {
            return true;
        } else {
            return false;
        }
    }
}