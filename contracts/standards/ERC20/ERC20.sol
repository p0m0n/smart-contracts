/*
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2025 p0m0n <https://github.com/p0m0n>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


pragma solidity >=0.8.0 <0.9.0;


import "./IERC20.sol";
import "contracts/utils/Context.sol";
import "contracts/standards/ERC165/ERC165.sol";

/*
 * @dev Implementation of the ERC-20 standard. <https://eips.ethereum.org/EIPS/eip-20>
 * A standard interface for tokens.
 *
 * Abstract:
 *  The following standard allows for the implementation of a standard API for tokens within smart contracts. 
 *  This standard provides basic functionality to transfer tokens, as well as allow tokens to be approved so they can be spent by another on-chain third party.
 *
 * Motivation:
 *  A standard interface allows any tokens on Ethereum to be re-used by other applications: from wallets to decentralized exchanges.
 */
abstract contract ERC20 is IERC20, Context, ERC165
{
    string private mName;                // Token name.
    string private mSymbol;              // Token symbol.
	
    uint256                                         private mTotalSupply = 0; // The total token supply.
    mapping(address => uint256)                     private mBalances;
    mapping(address => mapping(address => uint256)) private mAllowances;
    
    // Creates ERC-20 Standard.
    constructor(string memory _name, string memory _symbol)
    {
        // ERC20 interface ID (0x942e8b22).
        super._registerInterface(type(IERC20).interfaceId);
        mName   = _name;
        mSymbol = _symbol;
    }

    // Returns the name of the token - e.g. "MyToken".
    function name() public view virtual returns (string memory)
    {
        return mName;
    }
    
    // Returns the symbol of the token. E.g. “HIX”.
    function symbol() public view virtual returns (string memory)
    {
        return mSymbol;
    }
    
    // Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation.
    function decimals() public view virtual returns (uint8)
    {
        return 18;
    }
    
    // Returns the total token supply.
    function totalSupply() public view virtual returns (uint256)
    {
        return mTotalSupply;
    }
    
    // Returns the account balance of another account with address _owner.
    function balanceOf(address _owner) public view virtual returns (uint256)
    {
	    return mBalances[_owner];
    }
    
    // Transfers _value amount of tokens to address _to, and MUST fire the Transfer event.
    function transfer(address _to, uint256 _value) public virtual returns (bool)
    {
	    address _owner = _sysSender();
        return _transfer(_owner, _to, _value);
    }
    
    // Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.
    // The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf. 
    // This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies. 
    // The function SHOULD throw unless the _from account has deliberately authorized the sender of the message via some mechanism.
    //
    // NOTE: Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool)
    {
        address _spender = _sysSender();
        return _transferFrom(_spender, _from, _to, _value);
    }
    
    // Allows _spender to withdraw from your account multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value.
    //
    // NOTE: To prevent attack vectors like the one described here and discussed here, clients SHOULD make sure to create user interfaces in such a way that they set the allowance first to 0 before setting it to another value for the same spender. 
    //       THOUGH The contract itself shouldn’t enforce it, to allow backwards compatibility with contracts deployed before
    function approve(address _spender, uint256 _value) public virtual returns (bool)
    {
	    address _owner = _sysSender();
        return _approve(_owner, _spender, _value, true);
    }
    
    // Returns the amount which _spender is still allowed to withdraw from _owner.
    function allowance(address _owner, address _spender) public view virtual returns (uint256)
    {
        return mAllowances[_owner][_spender];
    }

    // Checks if a contract implements the given interface {_interfaceId} if yes then returns true, otherwise false.
    function supportsInterface(bytes4 _interfaceId) public view virtual override(ERC165, IERC165) returns (bool) 
    {
        return _interfaceId == type(IERC20).interfaceId || super.supportsInterface(_interfaceId);
    }

    /*********************************************************************
     *                        INTERNAL FUNCTIONS                         *
     *********************************************************************/

    // Handles the internal logic of transferring tokens between addresses.
    function _transfer(address _from, address _to, uint256 _value) internal returns (bool)
    {
	    if (_from == address(0))
		{
            revert("ERC20: invalid sender address");
        }
		
		if (_to == address(0))
		{
            revert("ERC20: invalid receiver address");
        }
        
        _update(_from, _to, _value);
        return true;
    }

    // Handles the internal logic of transferring tokens on behalf of another person.
    function _transferFrom(address _spender, address _from, address _to, uint256 _value) internal virtual returns (bool)
    {
        _spendAllowance(_from, _spender, _value);
        return _transfer(_from, _to, _value);
    }
    
    function _approve(address _owner, address _spender, uint256 _value, bool _events) internal virtual returns (bool)
    {
	    if (_owner == address(0))
		{
            revert("ERC20: invalid approve address");
        }
		
        if (_spender == address(0))
		{
            revert("ERC20: invalid spender address");
        }
        
        unchecked 
        {
            mAllowances[_owner][_spender] = _value;
        }

		if (_events)
        {
		    emit Approval(_owner, _spender, _value);
        }
        return true;
    }
    
    // Creates new tokens and increases the total volume.
    function _mint(address _account, uint256 _value) internal
    {
        if (_account == address(0))
		{
            revert("ERC20: mint to the zero address");
        }

        _update(address(0), _account, _value);
    }
    
    // Destroys tokens and limits the total supply.
    function _burn(address _account, uint256 _value) internal
    {
        if (_account == address(0)) 
        {
            revert("ERC20: burn from the zero address");
        }

        _update(_account, address(0), _value);
    }

    // Updates the sender and recipient balances and generates a Transfer event.
    function _update(address _from, address _to, uint256 _value) internal virtual 
    {
        if (_from == address(0)) 
        {
            mTotalSupply += _value;
        } 
        else 
        {
            uint256 fromBalance = mBalances[_from];
            if (fromBalance < _value) 
            {
                revert("ERC20: insufficient balance");
            }
            unchecked 
            {
                mBalances[_from] = fromBalance - _value;
            }
        }

        if (_to == address(0)) 
        {
            unchecked 
            {
                mTotalSupply -= _value;
            }
        } 
        else 
        {
            unchecked 
            {
                mBalances[_to] += _value;
            }
        }

        emit Transfer(_from, _to, _value);
    }
	
    // Reduces the permission to use tokens after transfer.
	function _spendAllowance(address _owner, address _spender, uint256 _value) internal virtual 
	{
        uint256 currentAllowance = allowance(_owner, _spender);
        if (currentAllowance != type(uint256).max) 
        {
            if (currentAllowance >= _value) 
            {
                unchecked 
                {
                    _approve(_owner, _spender, currentAllowance - _value, false);
                }
            } 
            else 
            {
                revert("ERC20: insufficient allowance");
            }
        }
    }
}
