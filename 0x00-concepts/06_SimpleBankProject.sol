// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleBankProject
 * @dev A comprehensive mini-project combining variables, addresses, functions, visibility, modifiers, and events.
 * This contract acts as a very basic centralized bank where anyone can deposit funds,
 * but only the bank manager (owner) can withdraw the total deposited funds.
 */
contract SimpleBankProject {
    
    // ==========================================
    // --- STATE VARIABLES ---
    // ==========================================
    // The `payable` address of the bank owner. They need to receive Ether, so they must be payable.
    address payable public bankOwner; 
    
    // A string to give our bank a name. It's public, so anyone can read it.
    string public bankName = "Decentralized First Bank";

    // ==========================================
    // --- EVENTS ---
    // ==========================================
    // We want to keep a history of every deposit made.
    // 'indexed' lets us search for deposits by a specific user address later.
    event DepositMade(address indexed account, uint256 amount);
    
    // We also want to log when the bank owner withdraws funds for transparency.
    event FundsWithdrawn(address indexed owner, uint256 amount);

    // ==========================================
    // --- MODIFIERS ---
    // ==========================================
    // A security guard for our withdrawal function.
    // We only want the `bankOwner` to have access to certain sensitive actions.
    modifier onlyBankOwner() {
        // Evaluate if the person calling the contract is the owner we set during deployment.
        require(msg.sender == bankOwner, "Access Denied: Only the bank owner can call this function.");
        // If they are, continue executing the function body.
        _;
    }

    // ==========================================
    // --- CONSTRUCTOR ---
    // ==========================================
    // Runs automatically ONE TIME when the contract is deployed to the blockchain.
    constructor() {
        // Set the bankOwner to the address that deployed the contract.
        // We must cast `msg.sender` to `payable` because `bankOwner` is a payable address.
        bankOwner = payable(msg.sender);
    }

    // ==========================================
    // --- CORE FUNCTIONS ---
    // ==========================================

    // 1. DEPOSIT FUNDS
    // Allows any user to send Ether to the bank.
    // Must be `payable` to receive the native cryptocurrency.
    function deposit() public payable {
        // Security check: Make sure they are actually sending more than 0 Ether.
        // `msg.value` contains the amount of Ether (in wei) sent with this transaction.
        require(msg.value > 0, "Deposit Failed: Amount must be greater than zero.");
        
        // Note: The EVM automatically adds `msg.value` to the contract's total balance.
        // We don't need to manually write `balance = balance + msg.value`.
        
        // Log the successful deposit to the blockchain for the frontend to see.
        emit DepositMade(msg.sender, msg.value);
    }

    // 2. CHECK BANK BALANCE
    // A free, read-only function to see how much Ether the bank holds in total.
    function getBankBalance() public view returns (uint256) {
        // `address(this).balance` returns the total amount of Ether held by this contract instance.
        return address(this).balance;
    }

    // 3. WITHDRAW FUNDS
    // Allows the bank owner to transfer all collected Ether out of the contract to their own wallet.
    // We protect this function using our `onlyBankOwner` modifier!
    function withdrawBankFunds() public onlyBankOwner {
        // Get the current balance of the entire contract.
        uint256 balanceToWithdraw = address(this).balance;
        
        // Ensure there are actually funds to withdraw, otherwise don't waste gas.
        require(balanceToWithdraw > 0, "Withdrawal Failed: No funds available in the bank.");
        
        // Emitting the event BEFORE the transfer is considered a best practice 
        // to prevent Reentrancy attacks (though less relevant here, it's a good habit).
        emit FundsWithdrawn(bankOwner, balanceToWithdraw);

        // Transfer all the Ether to the bankOwner's address.
        // Since `bankOwner` was declared as `payable`, it has access to the `.transfer()` method.
        bankOwner.transfer(balanceToWithdraw);
    }
}
