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


import "./IERC5313.sol";
import "contracts/utils/Context.sol";

/*
 * Implementation of the ERC-5313 standard. <https://eips.ethereum.org/EIPS/eip-5313>
 * This is a stripped-down alternative to ERC-173.
 */
abstract contract ERC5313 is IERC5313, Context
{
    // contract owner address.
    address internal mOwner;

    constructor(address _initOwner)
    {
	    // Sets the owner of the contract and raises an event.
	    mOwner = _initOwner;
    }

	// Throws if called by any account other than the owner.
    modifier onlyOwner()
	{
        require(_sysSender() == mOwner, "ERC5313: Caller is not the owner");
        _;
    }

	// Returns the owner's address, if it returns 0
	// then the contract does not belong to anyone.
    function owner() public view override returns(address)
	{
	    return mOwner;
	}
}
