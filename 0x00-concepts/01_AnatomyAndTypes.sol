// SPDX-License-Identifier: MIT
// 1. SPDX License Identifier: This tells the compiler the open-source license of the code.
// MIT is a standard open-source license often used in Web3.

// 2. Pragma Directive: This specifies the exact version of the Solidity compiler to use.
// The caret (^) means "compatible with version 0.8.0 and above, up to but not including 0.9.0".
// This protects your contract from being compiled with a breaking, newer version.
pragma solidity ^0.8.0;

// 3. Contract Declaration: The `contract` keyword is similar to `class` in Object-Oriented Programming.
// Everything inside the curly braces `{}` belongs to this specific contract.
// We name it "AnatomyAndTypes" to match our lesson.
contract AnatomyAndTypes {
    
    // ==========================================
    // --- 4. DATA TYPES (State Variables) ---
    // ==========================================
    
    // Unsigned Integers: Variables that hold non-negative whole numbers (no fractions, no negative numbers).
    // `uint256` means a 256-bit unsigned integer. (You can also just use `uint` as an alias).
    // The `public` keyword automatically creates a "getter" function so anyone can read this value.
    uint256 public myNumber = 100;
    
    // Booleans: Variables that can only be `true` or `false`.
    // Useful for flags, like checking if a task is done.
    bool public isCompleted = false;
    
    // Address: A unique 20-byte identifier for an Ethereum account or smart contract.
    // Think of this like a bank account number on the blockchain.
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    // Strings: Used to store text data.
    // In Solidity, strings cost more gas to store than numbers, so they are used sparingly.
    string public myGreeting = "Hello, Web3!";
    
    // Bytes: A dynamic sequence of raw bytes.
    // Often used instead of strings for arbitrary hexadecimal data or cryptographic hashes.
    bytes public myData = "0x1234";

}
