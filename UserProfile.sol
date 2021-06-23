// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

contract UserProfile {
    address private _player;
    
    constructor(address player) public {
        _player = player;
    }

}