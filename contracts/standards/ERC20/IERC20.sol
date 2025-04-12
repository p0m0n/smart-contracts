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


 /// @dev Interface of the ERC-20 standard.
interface IERC20
{   
    // Returns the name of the token - e.g. "MyToken".
    function name() external view returns (string memory);
    
    // Returns the symbol of the token. E.g. “HIX”.
    function symbol() external view returns (string memory);
    
    // Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation.
    function decimals() external view returns (uint8);

    // Returns the total token supply.
    function totalSupply() external view returns (uint256);
    
    // Returns the account balance of another account with address _owner.
    function balanceOf(address _owner) external view returns (uint256 balance);
    
    // Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. 
    // The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend.
    function transfer(address _to, uint256 _value) external returns (bool success);
    
    // Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    
    // Allows _spender to withdraw from your account multiple times, up to the _value amount. 
    // If this function is called again it overwrites the current allowance with _value.
    function approve(address _spender, uint256 _value) external returns (bool success);
    
    // Returns the amount which _spender is still allowed to withdraw from _owner.
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    
    // MUST trigger when tokens are transferred, including zero value transfers.
    // A token contract which creates new tokens SHOULD trigger a {Transfer} event with the {_sender} address set to {0x0} when tokens are created.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    // MUST trigger on any successful call to approve
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
