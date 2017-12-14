pragma solidity ^0.4.18;

contract Polls {
    struct Poll {
        string title;
        string question;
        string option1;
        string option2;
        uint count1;
        uint count2;
        mapping (address => bool) voted;
        bool exists;
    }

    mapping (string => Poll) polls;
    
    function createPoll (string _question, string _name, string _option1, string _option2) public {
        polls[_name].title = _name;
        polls[_name].question = _question;
        polls[_name].option1 = _option1;
        polls[_name].option2 = _option2;
        polls[_name].count1 = 0;
        polls[_name].count2 = 0;
        polls[_name].exists = true;
    }

    function vote (string optionName, string pollName) public {
        require(doesPollExist(pollName));
        require(hasAlreadyVoted(pollName));
        
        polls[pollName].voted[msg.sender] = true;

        if (keccak256(polls[pollName].option1) == keccak256(optionName)) {
            polls[pollName].count1 += 1;
        } else {
            polls[pollName].count2 += 1;
        }
    }

    function getPollName (string pollName) public view returns (string) {
        require(doesPollExist(pollName));

        return polls[pollName].question;
    }

    function getOption1 (string pollName) public view returns (string) {
        require(doesPollExist(pollName));

        return polls[pollName].option1;
    }
    
    function getOption2 (string pollName) public view returns (string) {
         require(doesPollExist(pollName));

        return polls[pollName].option2;
    }

    function getPollCounts (string pollName) public view returns (uint[2]) {
        require(doesPollExist(pollName));

        return [polls[pollName].count1, polls[pollName].count2];
    }

    function doesPollExist (string pollName) private view returns (bool) {
        if (polls[pollName].exists) {
            return true;
        } else {
            return false;
        }
    }
    
    function hasAlreadyVoted (string pollName) private view returns (bool) {
        if (polls[pollName].voted[msg.sender]) {
            return false;
        } else {
            return true;
        }
    }
}