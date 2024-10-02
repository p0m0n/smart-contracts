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
 * @title Ownable
 * The abstract contract has an owner address, and provides basic authorization control functions, this simplifies the implementation of "user permissions".
 * 
 * This module is used through inheritance.
 */
abstract contract Ownable
{
    address private _owner;
    
	// event for EVM logging
	event OwnerSet(address indexed oldOwner, address indexed newOwner);
    
	// The {Ownable} constructor sets the initial {owner} of the contract when deployed.
    constructor()
    {
        _owner = Context.msgSender();
        emit OwnerSet(address(0), _owner);
    }
    
    function owner() public view returns (address) { return _owner; }
    
	// Throws if called by any account other than the owner.
    modifier onlyOwner()
    {
        if ((owner() != address(0)) && (Context.msgSender() != owner()))
        {
            revert("Caller is not owner");
        } _;
    }
    
	// Allows you to change the owner of the contract.
    function changeOwner(address newOwner) public onlyOwner virtual
    {
        emit OwnerSet(_owner, newOwner);
        _owner = newOwner;
    }
}
