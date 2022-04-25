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


import "./ERC20.sol";
import "../access/Ownable.sol";
import "../access/Pausable.sol";
import "../access/BannedAccount.sol";


/**
 * @title ERC-20 Token Extension.
 * The extension implementation of the standard ERC-20 Token.
 * 
 * <https://eips.ethereum.org/EIPS/eip-20>
 **/
contract ERC20Ex is ERC20, Ownable, BannedAccount, Pausable
{
    string private mInformation;
    
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initSupply) ERC20(_name, _symbol, _decimals)
    {
        if (_initSupply != 0)
        {
            _minted(Context.msgSender(), _initSupply);
        }
        
        mInformation = "ERC-20 Token Extension";
    }
    
    function transfer(address recipient, uint256 amount) public onlyPayloadSize(2*32) virtual whenPaused override returns (bool)
    {
        address current = Context.msgSender();
        TryBannedAddress(current);
        TryBannedAddress(recipient);
        return _transfer(current, recipient, amount);
    }
    
    function transferFrom(address sender, address recipient, uint256 amount) public onlyPayloadSize(3*32) virtual whenPaused override returns (bool)
    {
        address current = Context.msgSender();
        TryBannedAddress(current);
        TryBannedAddress(sender);
        TryBannedAddress(recipient);
        return _transferFrom(current, sender, recipient, amount);
    }
    
    function approve(address spender, uint256 amount) public onlyPayloadSize(2*32) virtual override returns (bool)
    {
        address current = Context.msgSender();
        TryBannedAddress(current);
        TryBannedAddress(spender);
        return _approve(current, spender, amount);
    }
    
    function information() public view virtual returns (string memory)
    {
        return mInformation;
    }
    
    function setInformation(string memory _info) public onlyOwner virtual
    {
        mInformation = _info;
    }
    
    function minted(uint256 amount) public onlyOwner virtual returns (bool)
    {
        return _minted(Context.msgSender(), amount);
    }
    
    function burned(uint256 amount) public onlyOwner virtual returns (bool)
    {
        return _burned(Context.msgSender(), amount);
    }
    
    function bannedAddress(address account) public onlyOwner virtual
    {
        _bannedAddress(account);
    }

    function unbanedAddress(address account) public onlyOwner virtual
    {
        _unbanedAddress(account);
    }
    
    function pause() public onlyOwner virtual
    {
        _pause();
    }
    
    function unpause() public onlyOwner virtual
    {
        _unpause();
    }
    
    function sweep() public onlyOwner
    {
        uint256 balance = address(this).balance;
        payable(Context.msgSender()).transfer(balance);
    }
    
    function ClearBannedAccount(address account) public onlyOwner returns (bool)
    {
        if (statusAddress(account) != false)
        {
            uint256 value         = balanceOf(account);
            mTotalSupply         -= value;
            mDataBalance[account] = 0;
            emit ClearBaned(account, value);
            return true;
        }
        
        revert("ERC20Ex: address is not banned.");
    }
}



contract TestERC20Ex is ERC20Ex
{
    constructor() ERC20Ex("ERC-20-EXTENSION", "ERC20E", 18, 0)
    {
    }
}

