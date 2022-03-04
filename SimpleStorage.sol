// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    //// favUNum will be initialized to 0 if declared without initialization

    //// by adding public after uint256, you will be able to see the number, if not defined, by default
    //// set to internal
    //// public variables automatically have a "view" function
    uint256 favUNum = 5; // index 0
    bool favBool = false; // index 1

    // bool favBool = false;
    // string favStr = "Vai";
    // int256 favNum = -5;
    // address favAdr = 0x1cD339F1a67758778228c2fc368069128d3bce02;
    // bytes32 favBytes = "cat";
    // bytes1 to bytes 32

    struct People {
        uint256 favPNum;
        string name;
    }

    // People public person = People({favPNum: 2, name: "Vai"});
    People[] public people;
    mapping(string => uint256) public nameToFavNum;

    function changeNum(uint256 _favUNum) public {
        favUNum = _favUNum;
    }

    //// view, pure, are non-state changing functions. "pure" is used to exclusively do math in 
    //// a function
    function retrieve() public view returns(uint256) {
        return favUNum;
    }

    function doMath() public returns(uint256){
        favUNum = favUNum*2;
        return favUNum;
    }

    // "memory", "storage", and "callback" used depending on different circumstances
    function addPerson(uint256 _favUNum, string memory _name) public {
        // people.push(People({favPNum: _favUNum, name: _name}));
        people.push(People(_favUNum, _name));
        nameToFavNum[_name] = _favUNum;
    }
    
}
