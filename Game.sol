// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;
import './UserProfile.sol';
import './IStdReference.sol';

contract Game {
    IStdReference _ref;
    uint256 private _pool;
    UserProfile private _playera;
    UserProfile private _playerb;
    
    uint256 private _creationDate;
    uint256 private _initialValue;
    
    constructor(IStdReference ref) public {
        _ref = ref;
        _creationDate = getBTCLastDate();
        _initialValue = getBTCPrice();
    }
    
    function getCreationDate() public view returns (uint256) {
        return _creationDate;
    }
    
    function getInitialValue() public view returns (uint256) {
        return _initialValue;
    }
    
    //Bitcoin price fetching
    function getBTCPrice() private view returns (uint256){
        IStdReference.ReferenceData memory data = _ref.getReferenceData("BTC","USD");
        return data.rate;
    }
    
    function getBTCLastDate() private view returns (uint256){
        IStdReference.ReferenceData memory data = _ref.getReferenceData("BTC","USD");
        return data.lastUpdatedQuote;
    }

}