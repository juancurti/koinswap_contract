// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;
import './IStdReference.sol';

contract Game{
    IStdReference _ref;
    address _owner;
    
    uint256 private _totalUsers;
    mapping(uint256 => address) private _user;
    mapping(address => uint256) private _totalRewards;
    
    constructor() public {
        _ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
        _owner = msg.sender;
    }
    
    //Rewards
    function totalRewards() external view returns (uint256) {
        if(_totalUsers == 0) {
            return 0;
        }else{
            uint256 _total = 0;
            
            for(uint256 i=1; i < _totalUsers;i++) {
                _total = _total + _totalRewards[_user[i]];
            }
            
            return _total;
        }
    }
    
    function rewardsByPlayer(address player) external view returns (uint256) {
        if(_totalUsers == 0) {
            return 0;
        }else{
            uint256 _userRewards;
            
            for(uint256 i=1; i < _totalUsers;i++) {
                if(_user[i] == player) {
                    _userRewards = _totalRewards[_user[i]];
                }
            }
            
            return _userRewards;
        }
    }
    
    //Bitcoin price fetching
    function getLastBTCPrice() external view returns (uint256){
        IStdReference.ReferenceData memory data = _ref.getReferenceData("BTC","USD");
        return data.rate;
    }

}