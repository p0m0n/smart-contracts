# ERC-173

**ERC173** — Implementation of the Contract Ownership Standard [EIP-165](https://eips.ethereum.org/EIPS/eip-173)

---

### 🔧 Possibilities `ERC173`:

| Method                       | Description                                               |
|------------------------------|-----------------------------------------------------------|
| `owner()`                    | Returns the owner address                                 |
| `transferOwnership(address)` | Sets the address of the new owner of the contract         |

---

## ✅ Example of use

```solidity
pragma solidity ^0.8.20;

import "./ERC173.sol";

contract MyContract is ERC173 {
    constructor() ERC173(_sysSender())
    {
    }

    // Only the owner can use this feature.
    function myMethod() public onlyOwner returns (string memory) {
        return "Hello World!";
    }
}
```
