// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol"; 

contract StorageFactory is SimpleStorage {

    SimpleStorage[] public simpleStorageArray;

    function createStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sFStore(uint256 SSI, uint256 simpleStorageNumber) public {
        //// Address and ABI (Application Binary Interface) essential for interacting
        //// with a contract 

        // SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[SSI]));
        // simpleStorage.changeNum(simpleStorageNumber);

        SimpleStorage(address(simpleStorageArray[SSI])).changeNum(simpleStorageNumber);
    }

    function sFGet(uint256 SSI) public view returns (uint256) {
        // SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[SSI]));
        // return simpleStorage.retrieve();

        return SimpleStorage(address(simpleStorageArray[SSI])).retrieve();
    }
}
