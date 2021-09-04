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


import "./Ownable.sol";


/**
 * @title BannedAccount
 * This abstract contract allows you to banned or unbanned unwanted users.
 * 
 * This module is used through inheritance.
 */
abstract contract BannedAccount is Ownable
{
    mapping (address => bool) private mBannedList;
    
    function statusAddress(address account) public view returns (bool banned)
    {
        banned = mBannedList[account];
    }

    function bannedAddress(address account) public onlyOwner virtual
    {
        mBannedList[account] = true;
        emit Baned(account);
    }

    function unbanedAddress(address account) public onlyOwner virtual
    {
        mBannedList[account] = false;
        emit Unbaned(account);
    }
    
    function TryBannedAddress(address account) internal virtual
    {
        if (statusAddress(account) != false)
        {
            revert("BannedAccount: This address is banned.");
        }
    }
    
    event Baned(address indexed account);
    event Unbaned(address indexed account);
}
