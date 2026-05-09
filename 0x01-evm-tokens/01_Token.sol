// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// A basic, beginner-friendly ERC-20 style token.
// The goal is to show every standard attribute and behavior clearly.
contract BasicToken {
    // ----- Token metadata -----
    // Human-readable token name (e.g., "My Token").
    string public name;
    // Short token symbol (e.g., "MTK").
    string public symbol;
    // Number of decimals the token uses (typically 18).
    uint8 public decimals;

    // ----- Core accounting -----
    // Total amount of tokens in existence.
    uint256 public totalSupply;

    // Each address holds a balance of tokens.
    mapping(address => uint256) public balanceOf;

    // Allowances: owner => (spender => amount).
    // This lets an owner approve a spender to move tokens on their behalf.
    mapping(address => mapping(address => uint256)) public allowance;

    // ----- Events -----
    // Emitted whenever tokens move between addresses.
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Emitted when an owner sets a spender's allowance.
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor runs once on deployment and sets up token metadata and supply.
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        // Store metadata so wallets and explorers can display the token nicely.
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        // Mint the initial supply to the deployer (the address creating the contract).
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;

        // Emit a Transfer from the zero address to show minting in logs.
        emit Transfer(address(0), msg.sender, _initialSupply);
    }

    // Move tokens from the caller to another address.
    function transfer(address to, uint256 value) external returns (bool) {
        // The recipient must be a real address.
        require(to != address(0), "Invalid recipient");
        // The sender must have enough tokens.
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        // Update balances.
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        // Emit the standard Transfer event.
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // Approve a spender to transfer up to `value` tokens on the caller's behalf.
    function approve(address spender, uint256 value) external returns (bool) {
        // The spender must be a real address.
        require(spender != address(0), "Invalid spender");

        // Set the allowance.
        allowance[msg.sender][spender] = value;

        // Emit the standard Approval event.
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // Transfer tokens from `from` to `to` using the caller's allowance.
    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        // The recipient must be a real address.
        require(to != address(0), "Invalid recipient");
        // The source must have enough tokens.
        require(balanceOf[from] >= value, "Insufficient balance");
        // The caller must have enough allowance.
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");

        // Decrease allowance first (prevents double-spend with re-entrancy patterns).
        allowance[from][msg.sender] -= value;

        // Move the tokens.
        balanceOf[from] -= value;
        balanceOf[to] += value;

        // Emit the standard Transfer event.
        emit Transfer(from, to, value);
        return true;
    }
}
