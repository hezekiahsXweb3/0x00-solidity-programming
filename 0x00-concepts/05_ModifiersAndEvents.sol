// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract demonstrates Modifiers (how to restrict access)
// And Events (how to efficiently log data from smart contracts onto the EVM).
contract ModifiersAndEvents {
    // State variables representing the owner of the contract and an arbitrary count
    address public owner;
    uint256 public count;

    // ==========================================
    // --- 1. EVENTS ---
    // ==========================================
    // Events allow smart contracts to permanently log "activities" on the blockchain
    // using "topics" (indexed arguments).
    // Front-end decentralized applications (dApps) like React listen to these 
    // real-time notifications via Web3.js / Ethers.js to update the UI instantly.
    // They are significantly cheaper in gas compared to storing long historical arrays
    // in state variables!
    
    // The `event` keyword declares an event structure.
    // `indexed` allows the front end to specifically search/filter past logs 
    // by this exact variable (e.g. "Find all updates made ONLY by this address").
    event CountUpdated(address indexed updater, uint256 newCount);

    // The special constructor runs ONLY ONCE when the contract is deployed.
    constructor() {
        // We set the initial state variable `owner` to whoever deployed the contract initially!
        owner = msg.sender;
    }

    // ==========================================
    // --- 2. MODIFIERS ---
    // ==========================================
    // A Modifier is a reusable piece of logic that checks a required condition
    // BEFORE the actual function executes. It cleans up the smart contract
    // code significantly when multiple functions need the exact same access control rules!
    
    // The `modifier` keyword declares a custom modifier block.
    // Let's create an `onlyOwner` access lock!
    modifier onlyOwner() {
        // `require()` checks a condition (is the caller the owner?)
        // If the condition is False, it immediately reverts the transaction with an error message
        // and safely refunds any remaining gas back to the caller!
        require(msg.sender == owner, "Error: Access Denied! You are not the owner!");
        
        // This tiny underscore `_;` is VERY important.
        // It acts as a placeholder for the modified function's actual body code.
        // It says: "Only if the require statement above passes, THEN execute the rest of the function!"
        _;
    }

    // How to use the modifier:
    // Notice we simply add `onlyOwner` to the function declaration!
    function incrementCount() public onlyOwner {
        // --- 1. State Interaction ---
        // Because of the modifier, ONLY the contract owner can reach this code block.
        // Anyone else's transaction would have successfully failed by now.
        // We increase the count by 1.
        count += 1;
        
        // --- 2. Emitting Events ---
        // Let's broadcast this update to any external dApps listening!
        // We use the `emit` keyword followed by the Event Name we declared earlier.
        // We pass in the address of the person who called the function (the owner in this case),
        // and the new state variable `count` value.
        emit CountUpdated(msg.sender, count);
    }
}
