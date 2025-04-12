/* 
 * SPDX-License-Identifier: MIT
 */


pragma solidity >=0.8.0 <0.9.0;

import "contracts/standards/ERC20/ERC20.sol";

contract ERC20Test is ERC20
{
    constructor() ERC20("ERC20Test", "TEST")
    {
    }

    function mint(uint256 _value) public
    {
        super._mint(msg.sender, _value);
    }
    
    function burn(uint256 _value) public
    {
        super._burn(msg.sender, _value);
    }
}
