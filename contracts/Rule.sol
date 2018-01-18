pragma solidity ^0.4.18;

/**
 * @title Individual Rule
 * @author Jitendra Chittoda
 */
contract Rule{

	function Rule() public {

	}

	/**
	 * @dev RuleEngine executes this condition.
	 * @return Returns the result
	 */
	function execute() public constant returns (bool) {
		//Write Conditions here
		return true;
	}
}