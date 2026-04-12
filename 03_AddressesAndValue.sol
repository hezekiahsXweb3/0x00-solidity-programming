// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract demonstrates the crucial difference between a standard address
// and an "address payable", and how an address can handle native Ether.
contract AddressesAndValue {
    
    // ==========================================
    // --- 1. REGULAR ADDRESSES ---
    // ==========================================
    // This is a standard 20-byte address.
    // It can hold tokens and represent an account, but it CANNOT inherently receive Ethereum directly
    // through standard built-in transfer functions (`transfer` or `send`).
    address public normalOwner;

    // ==========================================
    // --- 2. PAYABLE ADDRESSES ---
    // ==========================================
    // Adding the `payable` keyword makes an address capable of receiving exactly what it means: payments.
    // Specifically Native Ether (or AVAX on Avalanche, MATIC on Polygon).
    address payable public payableOwner;

    // The constructor is a special function that automatically runs EXACTLY ONCE
    // when the contract is deployed to the blockchain.
    constructor() {
        // `msg.sender` is implicitly a normal address by default.
        normalOwner = msg.sender;
        
        // We explicitly "cast" (convert) the `msg.sender` address to be `payable` here.
        // It allows this specific address to receive Ether from the contract.
        payableOwner = payable(msg.sender);
    }

    // ==========================================
    // --- 3. RECEIVING ETHER ---
    // ==========================================
    // For a contract function to accept Ether along with its call, it MUST have the `payable` modifier.
    // Without it, if a user tries to send Ether to this function, it will immediately fail and revert.
    function depositEther() public payable {
        // The amount of Ether sent with the transaction is temporarily stored in 
        // a global variable: `msg.value`. It's tracked in the smallest unit called "wei".
        
        // (1 Ether = 1,000,000,000,000,000,000 Wei)
        
        // When someone calls this function and attaches Ether, it's instantly added
        // to the overall Ethereum balance of the smart contract!
    }

    // ==========================================
    // --- 4. CHECKING BALANCE ---
    // ==========================================
    // Any address (even a smart contract object) has a specific `.balance` property attached to it.
    function getContractBalance() public view returns (uint256) {
        // `this` refers to the current contract instance itself.
        // By casting it as `address(this)`, we get the contract's unique address layout,
        // and then `.balance` fetches how much Ether value the contract currently holds.
        return address(this).balance; 
    }

    // ==========================================
    // --- 5. TRANSFERRING ETHER ---
    // ==========================================
    // Because we are modifying the state by sending value out, this is a WRITE function.
    function sendEtherToOwner(uint256 _amount) public {
        
        // SECURITY CHECK: We must ensure the contract actually has enough Ether to fulfill the request.
        // `require` checks a condition. If the condition evaluates to `false`, it throws the error text
        // and instantly stops the transaction, undoing all previous steps to protect the funds.
        require(address(this).balance >= _amount, "Error: Not enough ether in contract to send");
        
        // We take the explicitly payable address variable `payableOwner`
        // and use its built-in method `.transfer()` to send Ether out of the contract.
        // `_amount` is expressed in Wei.
        // If the transfer fails (e.g. out of gas), the entire transaction automatically reverts.
        payableOwner.transfer(_amount);
    }
}
