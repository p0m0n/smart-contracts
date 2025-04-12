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


import "./IERC165.sol";

/*
 * Implementation of the ERC-165 standard. <https://eips.ethereum.org/EIPS/eip-165>
 * Creates a standard method to publish and detect what interfaces a smart contract implements.
 *
 * The ERC165 module implements the EIP-165 standard, allowing a contract to declare which interfaces it supports and check for support from other contracts.
 * Used to improve interoperability between contracts and build dynamically extensible systems.
 *
 * Abstract:
 * Herein, we standardize the following:
 *   1. How interfaces are identified
 *   2. How a contract will publish the interfaces it implements
 *   3. How to detect if a contract implements ERC-165
 *   4  How to detect if a contract implements any given interface
 *
 * Motivation:
 * For some “standard interfaces” like the ERC-20 token interface, 
 * it is sometimes useful to query whether a contract supports the interface and if yes, which version of the interface, 
 * in order to adapt the way in which the contract is to be interacted with. 
 * Specifically for ERC-20, a version identifier has already been proposed. 
 * This proposal standardizes the concept of interfaces and standardizes the identification (naming) of interfaces.
 */
abstract contract ERC165 is IERC165 
{
    // Interface ID ERC-165
    bytes4 internal constant ERC165ID = type(IERC165).interfaceId;

    // Mapping to store supported interface IDs.
    mapping(bytes4 interfaceId => bool) internal _supportedInterfaces;

    constructor() 
    {
        // ERC165 interface ID (0x01ffc9a7).
        _registerInterface(ERC165ID);
    }

    // Checks if a contract implements the given interface {_interfaceId} if yes then returns true, otherwise false.
    function supportsInterface(bytes4 _interfaceId) public view virtual override returns (bool) 
    {
        return _supportedInterfaces[_interfaceId];
    }
	
	// Registers the interface identifier {_interfaceId}.
    function _registerInterface(bytes4 _interfaceId) internal 
    {
        require(_interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[_interfaceId] = true;
    }
}
