pragma solidity ^0.4.18;

import './Ownable.sol';

/**
 * @title Dynamic Rule Engine
 * @author Jitendra Chittoda
 */
contract RuleEngine is Ownable{

	//Mapping to store RuleAddress => enabled/disabled
	mapping(address => bool) public rules; 
	address[] public rulesArr;	
	uint256 public rulesCount;	

	function RuleEngine() public {

	}

	/**
	 * Add new rule address
	 */
	function addRule(address _ruleAddress) public onlyOwner {
		rules[_ruleAddress] = true;
		rulesArr.push(_ruleAddress);
		rulesCount += 1;
	}

	/**
	 * @dev Enable / Disable any rul
	 */
	function enableRule(address _ruleAddress, bool _val) public onlyOwner  {
		rules[_ruleAddress] = _val;	
	}

	/**
	 * @dev Executes all enabled rules present in this contract
	 */
	function executeAllRules() public constant returns (bool) {
		bool isPassed = false;
		for(uint256 i = 0 ; i < rulesCount ; i++) {
			if(rules[rulesArr[i]]) {
				isPassed = isPassed && IRule(rulesArr[i]).execute();	
			}			
		}
		return isPassed;
	}

	/**
	 * @dev Executes third party rules
	 */
	function executeRules(address[] _rules) public constant returns (bool) {
		bool isPassed = false;
		for(uint256 i = 0 ; i < _rules.length ; i++) {
			isPassed = isPassed && IRule(_rules[i]).execute();
		}
		return isPassed;
	}
}

/**
 * @title Interface for individual rules
 */
contract IRule{
	function execute() public constant returns (bool);
}