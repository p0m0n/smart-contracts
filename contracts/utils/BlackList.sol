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


import "contracts/utils/Context.sol";


/**
 * @title BlackList
 * @dev An abstract contract that provides a blacklist mechanism for addresses.
 * This contract can be used in projects where it is necessary to temporarily or permanently
 * block certain addresses from performing actions (e.g., token transfers).
 *
 * Intended to be used as a base class for inheritance. The list is managed via the
 * internal `setBlacklist` function, and checked via `isBlacklist`.
 *
 * Motivation:
 * In real-world projects, especially financial ones, there is often a need
 * to restrict access of certain addresses to the functionality of a smart contract.
 *
 * Example use cases:
 * - Bots or attackers performing suspicious activity
 * - Lost or compromised wallets
 * - Addresses that violated terms of service
 *
 * The blacklist mechanism allows for flexible and secure blocking of such addresses.
 *
 * This contract provides basic functionality for:
 * - Adding and removing addresses from the blacklist
 * - Checking if an address is on the list
 * - Restricting access via modifiers
 *
 * The contract is abstract and designed to be extended in more complex systems.
 */
abstract contract BlackList is Context 
{
    /// @dev Mapping of addresses to their blacklist status (true = blacklisted, false = not blacklisted)
    mapping(address account => bool status) internal mBlacklist;

    /// @dev Emitted when an address is added to the blacklist
    event Blacklisted(address indexed _account);
    /// @dev Emitted when an address is removed from the blacklist
    event UnBlacklisted(address indexed _account);

    /**
     * @dev Modifier that allows function execution only if the address is NOT blacklisted.
     * Used to protect functions from being called by blocked addresses.
     * @param _account The address to check
     */
    modifier onlyBlacklisted(address _account) 
    {
        require(!isBlacklist(_account), "BlackList: address is blacklisted");
        _;
    }

    /**
     * @dev Checks if the specified address is blacklisted.
     * @param _account The address to check
     * @return true if the address is blacklisted; false otherwise
     */
    function isBlacklist(address _account) public view returns (bool) 
    {
        require(_account != address(0), "BlackList: invalid address");
        return mBlacklist[_account];
    }

    /**
     * @dev Adds or removes an address from the blacklist.
     * Internal function that can be called by derived contracts.
     * @param _account The address to add or remove
     * @param _status true to add to the blacklist, false to remove
     */
    function setBlacklist(address _account, bool _status) internal 
    {
        require(_account != address(0), "BlackList: invalid address");

        if (_status) 
        {
            // Add address to blacklist
            mBlacklist[_account] = true;
            emit Blacklisted(_account);
        } 
        else 
        {
            // Remove address from blacklist
            mBlacklist[_account] = false;
            emit UnBlacklisted(_account);
        }
    }
}
