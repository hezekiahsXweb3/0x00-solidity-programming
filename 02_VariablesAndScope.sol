// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract demonstrates the three main types of variables in Solidity:
// State variables, Local variables, and Global variables.
contract VariablesAndScope {
    
    // ==========================================
    // --- 1. STATE VARIABLES ---
    // ==========================================
    // State variables are declared outside of functions.
    // Their values are permanently stored in the blockchain's storage.
    // Reading them is free, but updating their value costs "gas" (transaction fees).
    // Because they use blockchain space, they are expensive to manage.
    
    uint256 public stateNumber = 50; 
    string public stateText = "I live permanently on the blockchain!";

    // A simple function that returns three different values to demonstrate variable scopes.
    // The `view` keyword tells the blockchain that this function only READS state, 
    // it doesn't change it, making it free to run.
    function demonstrateScope() public view returns (uint256, uint256, address) {
        
        // ==========================================
        // --- 2. LOCAL VARIABLES ---
        // ==========================================
        // Local variables are declared INSIDE a function.
        // They only exist in memory while this specific function is executing.
        // They are NOT saved to the blockchain, and storing data in them costs far less gas.
        
        uint256 localNumber = 10;
        
        // Let's create another local variable that adds our permanent state variable
        // with our temporary local variable.
        uint256 combinedNumber = stateNumber + localNumber; // Evaluates to 50 + 10 = 60.

        // ==========================================
        // --- 3. GLOBAL VARIABLES ---
        // ==========================================
        // Special variables injected automatically by the Ethereum Virtual Machine (EVM).
        // They provide contextual information about the current transaction or the block itself.
        
        // `msg.sender` holds the address of the person (or smart contract) calling this function right now.
        // It's the most common way to authenticate who is interacting with the contract.
        address callerAddress = msg.sender;
        
        // `block.timestamp` gives the timestamp of the current block in seconds since the Unix epoch.
        // Useful for checking if an action is allowed at a certain time.
        // (Commented out here just to keep the return statement simple).
        // uint256 timeRequested = block.timestamp; 

        // We return the local variable, the combined math operation, and the global caller address.
        // Notice we are returning multiple values at once.
        return (localNumber, combinedNumber, callerAddress);
    }
}
