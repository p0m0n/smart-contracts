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


/**
* @title Context
* @dev Wrapper over Solidity global variables for convenience and readability.
* Used as a base abstract contract in the standards framework.
*/
abstract contract Context
{
    // Returns the address of the current miner (or validator).
    function _sysCoinbase() internal view returns (address payable)
    {
        return block.coinbase;
    }

    // Returns the value of the prevrandao field (difficulty in PoS).
    function _sysPrevrandao() internal view returns (uint)
    {
        return block.prevrandao;
    }

    // Returns the current gas limit of the block.
    function _sysGaslimit() internal view returns (uint)
    {
        return block.gaslimit;
    }

    // Returns the current timestamp of the block.
    function _sysTimestamp() internal view returns (uint)
    {
        return block.timestamp;
    }

    // Returns the current block number.
    function _sysNumber() internal view returns (uint)
    {
        return block.number;
    }
	
	// Returns the ID of the current chain.
	function _sysChainId() internal view returns (uint)
	{
        return block.chainid;
    }

    // Returns the sender address of the current call.
    function _sysSender() internal view returns (address)
    {
        return msg.sender;
    }
    
    // Returns all call data.
    function _sysData() internal pure returns (bytes calldata)
    {
        return msg.data;
    }
    
    // Returns the number of wei sent with the call.
    function _sysValue() internal view returns (uint)
    {
        return msg.value;
    }
	
	// Returns the origin of the transaction address.
	function _sysOrigin() internal view returns (address) 
	{
        return tx.origin;
    }
}
