// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

import './IStdReference.sol';

contract PredictionGame {
    IStdReference ref;
    
    mapping (address => bool) private _waitingPlayers;

    constructor() public {
        ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
    }

    function getBTCPrice() external view returns (uint256){
        IStdReference.ReferenceData memory data = ref.getReferenceData("BTC","USD");
        return data.rate;
    }
    
    function participate() public {
        require(_waitingPlayers[msg.sender] != true, "PredictionGame: Player is already waiting for a new round");
        
        _waitingPlayers[msg.sender] = true;
    }
    
    function cancelParticipation() public {
         require(_waitingPlayers[msg.sender] == true, "PredictionGame: Player is not participating yet");
        
        _waitingPlayers[msg.sender] = false;
    }
    
    function isParticipant(address player) external view returns (bool) {
        return _waitingPlayers[player] == true;
    }
}