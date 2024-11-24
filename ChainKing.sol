// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ChainKing is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 777_777_777_777 * 10**18; // Maximum token supply (777 billion tokens)

    constructor() ERC20("ChainKing", "CK") Ownable(msg.sender) {
        // Mint the total supply to the deployer (contract creator)
        _mint(msg.sender, MAX_SUPPLY);
    }

    // Restrict minting to owner and ensure max supply is not exceeded
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds max supply");
        _mint(to, amount);
    }

    // Prevent renouncing ownership for security reasons
    function renounceOwnership() public override onlyOwner {
        revert("Ownership cannot be renounced");
    }
}