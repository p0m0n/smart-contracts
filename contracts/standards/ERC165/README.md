# ERC-165

**ERC165** — An implementation of the [EIP-165](https://eips.ethereum.org/EIPS/eip-165) standard that allows a smart contract to declare which interfaces it supports and check for support from other contracts. Used to improve interoperability between contracts and build dynamically extensible systems.

---

### 🔧 Possibilities `ERC165`:

| Method                       | Description                                               |
|------------------------------|-----------------------------------------------------------|
| `supportsInterface(bytes4)`  | Checks if the contract supports the specified interfaceId |
| `_registerInterface(bytes4)` | Internal method for registering interface support         |

---

## ✅ Example of use

```solidity
pragma solidity ^0.8.20;

import "./ERC165.sol";
import "./interfaces/IMyInterface.sol";

interface IMyInterface is IERC165
{
    function myMethod() external pure returns (string memory);
}

contract MyContract is ERC165, IMyInterface {
    constructor() {
        _registerInterface(type(IMyInterface).interfaceId);
    }

    function myMethod() external pure override returns (string memory) {
        return "Hello World!";
    }
}
```
