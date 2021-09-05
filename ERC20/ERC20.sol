/* 
 * SPDX-License-Identifier: MIT
 * Copyright (c) 2021 p0m0n <https://github.com/p0m0n>
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


pragma solidity >=0.7.0 <0.9.0;


import "./IERC20.sol";
import "../other/Context.sol";


/**
 * @title ERC-20 Token Standard.
 * The standard implementation of the ERC-20 Token.
 * 
 * The following standard allows for the implementation of a standard API for tokens within smart contracts.
 * This standard provides basic functionality to transfer tokens, as well as allow tokens to be approved so they can be spent by another on-chain third party.
 * 
 * <https://eips.ethereum.org/EIPS/eip-20>
 **/
contract ERC20 is IERC20
{
    string private mString;
    string private mSymbol;
    uint8  private mDecimal;
    
    uint256                                         internal mTotalSupply;
    mapping(address => uint256)                     internal mDataBalance;
    mapping(address => mapping(address => uint256)) internal mDataAllowed;
    
    // Creates ERC-20 Standard.
    constructor(string memory _name, string memory _symbol, uint8 _decimals)
    {
        mString  = _name;
        mSymbol  = _symbol;
        mDecimal = _decimals;
    }
    
    // Fix for the ERC-20 short address attack.
    modifier onlyPayloadSize(uint size)
    {
        require(!(Context.msgData().length < size + 4));
        _;
    }
    
    // Returns the name of the token - e.g. "Ethereum".
    function name() public view virtual override returns (string memory)
    {
        return mString;
    }
    
    // Returns the symbol of the token. E.g. "ETH".
    function symbol() public view virtual override returns (string memory)
    {
        return mSymbol;
    }
    
    // Returns the number of decimals the token uses - e.g. 8,
    function decimals() public view virtual override returns (uint8)
    {
        return mDecimal;
    }
    
    // Returns the total token supply.
    function totalSupply() public view virtual override returns (uint256)
    {
        return mTotalSupply;
    }
    
    // Returns the account balance of another account with {account}.
    function balanceOf(address account) public view virtual override returns (uint256)
    {
        return mDataBalance[account];
    }
    
    // Transfers {amount} of tokens to address {recipient}.
    function transfer(address recipient, uint256 amount) public onlyPayloadSize(2*32) virtual override returns (bool)
    {
        if (_transfer(Context.msgSender(), recipient, amount) != false)
            return true;

        revert("ERC-20:  transfer failed.");
    }
    
    // Transfers {amount} of tokens from address {sender} to address {recipient}.
    function transferFrom(address sender, address recipient, uint256 amount) public onlyPayloadSize(3*32) virtual override returns (bool)
    {
        if (_transferFrom(Context.msgSender(), sender, recipient, amount) != false)
            return true;

        revert("ERC-20:  transfer from failed.");
    }
    
    // Allows {spender} to withdraw from your account multiple times, up to the {amount}.
    function approve(address spender, uint256 amount) public onlyPayloadSize(2*32) virtual override returns (bool)
    {
        if (_approve(Context.msgSender(), spender, amount) != false)
            return true;

        revert("ERC-20:  approve failed.");
    }
    
    // Returns the amount which {spender} is still allowed to withdraw from {owner}.
    function allowance(address owner, address spender) public view virtual override returns (uint256)
    {
        return mDataAllowed[owner][spender];
    }
    
    
    /*********************************************************************
     *                                                                   *
     *          ERC-20 EXTENSION OR STANDARD INTERNAL FUNCTIONS          *
     *                                                                   *
     *********************************************************************/
    
    // Moves {amount} of tokens from {sender} to {recipient}.
    function _transfer(address sender, address recipient, uint256 amount) internal virtual returns (bool)
    {
        if ((sender == address(0)) || (recipient == address(0)))
            return false;
        
        if ((mDataBalance[sender] >= amount) && (amount > 0))
        {
            mDataBalance[sender]    -= amount;
            mDataBalance[recipient] += amount;
            emit Transfer(sender, recipient, amount);
            return true;
        }
        
        return false;
    }
    
    function _transferFrom(address spender, address sender, address recipient, uint256 amount) internal virtual returns (bool)
    {
        if (spender == address(0))
            return false;
            
        if ((_transfer(sender, recipient, amount) != false) && (mDataAllowed[sender][spender] >= amount))
        {
            mDataAllowed[sender][spender] -= amount;
            emit Approval(sender, spender, amount);
            return true;
        }
        
        return false;
    }
    
    // Sets {amount} as the allowance of {spender} over the {owner} s tokens.
    function _approve(address owner, address spender, uint256 amount) internal virtual returns (bool)
    {
        if ((owner == address(0)) || (spender == address(0)))
            return false;
        
        mDataAllowed[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }
    
    // Creates {amount} tokens and assigns them to {account}, increasing the total supply.
    function _minted(address account, uint256 amount) internal virtual returns (bool)
    {
        if ((account == address(0)) || (amount == uint256(0)))
            return false;
        
        mTotalSupply          += amount;
        mDataBalance[account] += amount;
        emit Minted(account, amount);
        return true;
    }
    
    // Destroys {amount} tokens from {account}, reducing the total supply.
    function _burned(address account, uint256 amount) internal virtual returns (bool)
    {
        if ((account == address(0)) || (amount == uint256(0)))
             return false;
        
        if ((mDataBalance[account] >= amount) && (amount > 0))
        {
            mTotalSupply          -= amount;
            mDataBalance[account] -= amount;
            emit Burned(account, amount);
            return true;
        }
        
        return false;
    }
}
