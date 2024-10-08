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


import "../other/Context.sol";


/**
 * @title Pausable
 * Contract module which allows to implement an emergency stop, mechanism that can be triggered by an authorized account.
 * 
 * This module is used through inheritance.
 */
abstract contract Pausable
{
    event Paused(address indexed account);
    event Unpaused(address indexed account);

    bool private _paused;

    constructor()
    {
        _paused = false;
    }
    
    function paused() public view returns (bool)
    {
        return _paused;
    }
    
    modifier whenPaused()
    {
        if (paused() != false)
        {
            revert("Pausable: paused");
        } _;
    }
    
    modifier whenNotPaused()
    {
        if (paused() != true)
        {
            revert("Pausable: not paused");
        } _;
    }
    
    function _pause() internal virtual
    {
        _paused = true;
        emit Paused(Context.msgSender());
    }
    
    function _unpause() internal virtual
    {
        _paused = false;
        emit Unpaused(Context.msgSender());
    }
}