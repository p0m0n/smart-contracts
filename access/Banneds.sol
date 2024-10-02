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


pragma solidity >=0.8.0 <0.9.0;


/**
 * @title Banneds
 * This abstract contract allows you to banned or unbanned unwanted users.
 * 
 * This module is used through inheritance.
 */
abstract contract Banneds
{
    mapping (address => bool) private mBannedList;
    
     // event for EVM logging
    event Baned(address indexed account);
    event Unbaned(address indexed account);
    event ClearBaned(address indexed account, uint256 indexed amount);
    
    function statusAddress(address account) public view returns (bool banned)
    {
        banned = mBannedList[account];
    }

    function _bannedAddress(address account) internal virtual
    {
        mBannedList[account] = true;
        emit Baned(account);
    }

    function _unbanedAddress(address account) internal virtual
    {
        mBannedList[account] = false;
        emit Unbaned(account);
    }
    
    function TryBannedAddress(address account) internal virtual
    {
        if (mBannedList[account] != false)
        {
            revert("Banneds: This address is banned.");
        }
    }
}
