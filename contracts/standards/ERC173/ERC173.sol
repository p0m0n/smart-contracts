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


import "./IERC173.sol";
import "contracts/utils/Context.sol";

/*
 * Implementation of the ERC-173 standard. <https://eips.ethereum.org/EIPS/eip-173>
 * Contract Ownership Standard
 *
 * Abstract:
 *  This specification defines standard functions for owning or managing a contract.
 *  The implementation allows the current owner to be read and ownership to be transferred, along with a standardized event for when ownership changes.
 * 
 * Motivation:
 *  Many smart contracts require that they be owned or controlled in some way. For example to withdraw funds or perform administrative actions. It is so common that the contract interface used to handle contract ownership should be standardized to allow compatibility with user interfaces and contracts that manage contracts.
 *  Here are some examples of kinds of contracts and applications that can benefit from this standard:
 *   1) Exchanges that buy/sell/auction ethereum contracts. This is only widely possible if there is a standard for getting the owner of a contract and transferring ownership.
 *   2) Contract wallets that hold the ownership of contracts and that can transfer the ownership of contracts.
 *   3) Contract registries. It makes sense for some registries to only allow the owners of contracts to add/remove their contracts. A standard must exist for these contract registries to verify that a contract is being submitted by the owner of it before accepting it.
 *   4) User interfaces that show and transfer ownership of contracts.
 */
abstract contract ERC173 is IERC173, Context
{
    // contract owner address.
    address internal mOwner;

    constructor(address _initOwner)
    {
	    // Sets the owner of the contract and raises an event.
	    mOwner = _initOwner;

		// The event should be emitted when a contract is created.
		emit OwnershipTransferred(address(0), _initOwner);
    }

	// Throws if called by any account other than the owner.
    modifier onlyOwner()
	{
        require(_sysSender() == mOwner, "ERC173: Caller is not the owner");
        _;
    }

	// Returns the owner's address, if it returns 0
	// then the contract does not belong to anyone.
    function owner() public view override returns(address)
	{
	    return mOwner;
	}

    // Sets the address of the new owner of the contract,
	// if you want to abandon the contract you need to set _newOwner to address(0).
    function transferOwnership(address _newOwner) public override onlyOwner
	{
	    require(_newOwner != mOwner, "ERC173: Already own the contract");

	    mOwner = _newOwner;
	    emit OwnershipTransferred(mOwner, _newOwner);
	}
}
