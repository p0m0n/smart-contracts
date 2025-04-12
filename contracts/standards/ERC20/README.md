# ERC-20

**ERC-20** is an implementation of the [EIP-20](https://eips.ethereum.org/EIPS/eip-20) standard for tokens in smart contracts.
It is a standard interface for tokens that provides basic functionality for transferring tokens, as well as for granting permissions for their spending by third parties.

---

### 🔧 Possibilities `ERC20`

| Method                                    | Description                                                   |
|-------------------------------------------|---------------------------------------------------------------|
| `name()`                                  | Returns the token name                                        |
| `symbol()`                                | Returns the token symbol (eg HIX)                             |
| `decimals()`                              | Returns the number of decimal places (default 18)             |
| `totalSupply()`                           | Returns the total amount of tokens                            |
| `balanceOf(address)`                      | Returns the token balance for the given address               |
| `transfer(address, uint256)`              | Transfers the specified amount of tokens to another address   |
| `transferFrom(address, address, uint256)` | Transfers tokens from one address to another using permission |
| `approve(address, uint256)`               | Allows a third party to withdraw tokens from your balance     |
| `allowance(address, address)`             | Returns the allowed limit for token withdrawals               |
| `supportsInterface(bytes4)`               | Checks if the contract supports the specified interfaceId     |

---

### 🔐 Internal functions

| Method                                              | Description                                          |
|-----------------------------------------------------|------------------------------------------------------|
| `_transfer(address, address, uint256)`              | Transferring tokens between addresses                |
| `_transferFrom(address, address, address, uint256)` | Transferring tokens on behalf of another user        |
| `_approve(address, address, uint256, bool)`         | Sets permission to withdraw tokens                   |
| `_mint(address, uint256)`                           | Creates new tokens and increases the total supply    |
| `_burn(address, uint256)`                           | Burns tokens and reduces the total supply            |
| `_update(address, address, uint256)`                | Updates balances and generates a Transfer event      |
| `_spendAllowance(address, address, uint256)`        | Reduces permission to withdraw tokens after transfer |

---

## ✅ Example of use

```solidity
pragma solidity ^0.8.20;

import "./ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {}

    // Additional methods and contract logic
}
```
