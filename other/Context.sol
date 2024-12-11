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
 * @title Global Variables
 */
library Context
{
    // get the current block miner’s address.
    function _coinbase() internal view returns (address payable)
    {
        return block.coinbase;
    }

    // get the current block difficulty.
    function _difficulty() internal view returns (uint)
    {
        return block.prevrandao;
    }

    // get the current block gaslimit.
    function _gaslimit() internal view returns (uint)
    {
        return block.gaslimit;
    }

    // get the current block timestamp.
    function _timestamp() internal view returns (uint)
    {
        return block.timestamp;
    }

    // get the current block number.
    function _number() internal view returns (uint)
    {
        return block.number;
    }

    // sender of the message (current call).
    function _sender() internal view returns (address)
    {
        return msg.sender;
    }
    
    // complete calldata.
    function _data() internal pure returns (bytes calldata)
    {
        return msg.data;
    }
    
    // number of wei sent with the message.
    function _value() internal view returns (uint)
    {
        return msg.value;
    }
}
