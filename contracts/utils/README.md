# Context

**Context** — is a modular and secure Solidity framework for creating your own smart contracts with advanced functionality, strict architecture, and transparent logic. All components of the framework are created with an emphasis on reusability, readability, and security.

---

### 🔧 Possibilities `Context`:

| Method             | Description                                             |
|--------------------|---------------------------------------------------------|
| `_sysSender()`     | Caller's address (`msg.sender`)                         |
| `_sysOrigin()`     | Initial Transaction Initiator                           |
| `_sysData()`       | Full input data (`msg.data`)                            |
| `_sysValue()`      | Number of wei sent with the call                        |
| `_sysCoinbase()`   | The address of the miner/validator of the current block |
| `_sysPrevrandao()` | Meaning `prevrandao` (equivalent difficulty)            |
| `_sysGaslimit()`   | Current block gas limit                                 |
| `_sysTimestamp()`  | Block timestamp (`block.timestamp`)                     |
| `_sysNumber()`     | Block number (`block.number`)                           |
| `_sysChainId()`    | Current chain ID (`block.chainid`)                      |

---

## ✅ Example of use

```solidity
pragma solidity ^0.8.20;

import "../utils/Context.sol";

contract MyContract is Context {
    function getSender() external view returns (address) {
        return _sysSender();
    }

    function getChainInfo() external view returns (uint number, uint chainId) {
        return (_sysNumber(), _sysChainId());
    }
} ```

---

# BlackList

**BlackList** — an abstract contract that provides a blacklisting mechanism for addresses.

---

### 🔧 Possibilities `BlackList`:

| Method                        | Description                                    |
|-------------------------------|------------------------------------------------|
| `isBlacklist(address)`        | Checks if the specified address is blacklisted |
| `setBlacklist(address, bool)` | Adds or removes an address from the blacklist  |

---

## ✅ Example of use

```solidity
pragma solidity ^0.8.20;

import "../utils/BlackList.sol";

contract MyContract is BlackList {
    function addToBlacklist(address _account) public onlyOwner
	{
	    super.setBlacklist(_account, true);
	}
	
	function removeBlacklist(address _account) public onlyOwner
	{
	    super.setBlacklist(_account, false);
	}
} ```
