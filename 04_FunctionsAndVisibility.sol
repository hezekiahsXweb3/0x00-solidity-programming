// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract demonstrates the core logic execution blocks: Functions.
// It explains how they modify state and who exactly is allowed to call them.
contract FunctionsAndVisibility {
    
    // An initial state variable that starts at 100.
    uint256 public dataVariable = 100;

    // ==========================================
    // --- 1. FUNCTION VISIBILITY MODIFIERS ---
    // ==========================================
    // Function visibility controls *where* a function can be called from.

    // PUBLIC: Can be called from ANYWHERE. This includes users directly interacting via a wallet,
    // other smart contracts, OR by other functions inside this very own contract.
    // It creates an automatic getter when used on state variables.
    function publicFunction() public pure returns (string memory) {
        return "I am PUBLIC and accessible everywhere!";
    }

    // EXTERNAL: Can ONLY be called from the OUTSIDE.
    // Other contracts and external users can call this, but functions *inside* this contract CANNOT.
    // Why use it? It's slightly more gas-efficient than `public` when passing large data (like arrays or structs),
    // because it reads directly from "calldata" instead of copying it to "memory" first.
    function externalFunction() external pure returns (string memory) {
        return "I am EXTERNAL! Only external actors can interact with me.";
    }

    // INTERNAL: Can ONLY be called from INSIDE this contract, OR by contracts that INHERIT from this one.
    // This is the default visibility if none is specified, but explicitly defining it is best practice.
    // It's like the "protected" keyword in languages like Java or C++.
    function internalFunction() internal pure returns (string memory) {
        return "I am INTERNAL! Safe inside this contract ecosystem.";
    }

    // PRIVATE: Can ONLY be called from INSIDE this exact contract.
    // Not even contracts that inherit from this one can call it.
    // This provides the strictest encapsulation and security.
    function privateFunction() private pure returns (string memory) {
        return "I am STRICTLY PRIVATE!";
    }

    // Helper function to demonstrate internal/private usage works inside the contract:
    // A public user calls this function below, which then internally calls the private and internal logic securely.
    function callHiddenFunctions() public pure returns (string memory) {
        // We can confidently call internal and private functions from another function within the same contract block.
        // It successfully returns the string data hidden by internal modifiers.
        return internalFunction(); 
    }

    // ==========================================
    // --- 2. EXECUTION LOGIC (STATE MUTABILITY) ---
    // ==========================================
    // State mutability keywords tell the EVM what a function will do with data stored on the blockchain.

    // WRITE FUNCTION: This function MODIFIES the permanent blockchain state.
    // It has NO special keywords like 'view' or 'pure'.
    // Changing state requires a transaction fee paid in Gas. Users will have to sign this message in their wallet.
    function updateData(uint256 _newData) public {
        // Because we assign a new value to the state variable `dataVariable`, we're changing the blockchain permanently!
        dataVariable = _newData; 
    }

    // READ (VIEW) FUNCTION: The `view` keyword means the function LOOKS at the state but promises NOT to change it.
    // Because it doesn't change anything, it's completely FREE for an external user to call from an off-chain application.
    function viewData() public view returns (uint256) {
        // It's returning the state variable safely.
        return dataVariable; 
    }

    // READ (PURE) FUNCTION: The `pure` keyword is the most restrictive.
    // It promises to NEITHER read state variables, NOR write state variables.
    // It completely relies on the arguments passed into it, and is completely free to call off-chain.
    function calculate(uint256 a, uint256 b) public pure returns (uint256) {
        // Notice we are NOT interacting with `dataVariable` here at all.
        // It just performs simple logic on user-provided inputs and instantly returns the result.
        return a + b; 
    }
}
