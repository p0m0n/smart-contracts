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


/**
 * @title IERC20 Token Standard.
 * A standard interface for tokens ERC-20.
 * 
 * The following standard allows for the implementation of a standard API for tokens within smart contracts.
 * This standard provides basic functionality to transfer tokens, as well as allow tokens to be approved so they can be spent by another on-chain third party.
 * 
 * <https://eips.ethereum.org/EIPS/eip-20>
 **/
interface IERC20
{
    // Returns the name of the token - e.g. "Ethereum".
    // OPTIONAL - This method can be used to improve usability,
    // but interfaces and other contracts MUST NOT expect these values to be present.
    function name() external view returns (string memory);
    
    // Returns the symbol of the token. E.g. “ETH”.
    // OPTIONAL - This method can be used to improve usability,
    // but interfaces and other contracts MUST NOT expect these values to be present.
    function symbol() external view returns (string memory);
    
    // Returns the number of decimals the token uses - e.g. 8,
    // means to divide the token amount by {100000000} to get its user representation.
    //
    // OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
    function decimals() external view returns (uint8);
    
    // Returns the total token supply.
    function totalSupply() external view returns (uint256);
    
    // Returns the account balance of another account with {account}.
    function balanceOf(address account) external view returns (uint256);
    
    // Transfers {amount} amount of tokens to address {recipient}, and MUST fire the {Transfer} event.
    // The function SHOULD {throw} if the message caller’s account balance does not have enough tokens to spend.
    //
    // Note Transfers of 0 values MUST be treated as normal transfers and fire the {Transfer} event.
    function transfer(address recipient, uint256 amount) external returns (bool);
    
    // Transfers {amount} amount of tokens from address {sender} to address {recipient}, and MUST fire the {Transfer} event.
    // The {transferFrom} method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf.
    // This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies.
    // The function SHOULD {throw} unless the {sender} account has deliberately authorized the sender of the message via some mechanism.
    //
    // Note Transfers of 0 values MUST be treated as normal transfers and fire the {Transfer} event.
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    
    // Allows {spender} to withdraw from your account multiple times, up to the {amount}.
    // If this function is called again it overwrites the current allowance with {amount}.
    //
    // NOTE: To prevent attack vectors like the one described here and discussed here,
    // clients SHOULD make sure to create user interfaces in such a way that they set the allowance first to 0 before setting it to another value for the same spender.
    //
    // THOUGH The contract itself shouldn’t enforce it, to allow backwards compatibility with contracts deployed before
    function approve(address spender, uint256 amount) external returns (bool);
    
    // Returns the amount which {spender} is still allowed to withdraw from {owner}.
    function allowance(address owner, address spender) external view returns (uint256);
    
    // MUST trigger when tokens are transferred, including zero value transfers.
    // A token contract which creates new tokens SHOULD trigger a {Transfer} event with the {_sender} address set to {0x0} when tokens are created.
    event Transfer(address indexed sender, address indexed recipient, uint256 value);
    
    // MUST trigger on any successful call to {approve}.
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    // MUST trigger on any successful call to {minted}.
    event Minted(address indexed account, uint256 amount);
    
    // MUST trigger on any successful call to {burned}.
    event Burned(address indexed account, uint256 amount);
}
