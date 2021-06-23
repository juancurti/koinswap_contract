// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;
import './IStdReference.sol';
import './Game.sol';

contract KoinSwapGame {
    IStdReference ref;
    
    uint256 private _gameCount;
    mapping (uint256 => Game) private _games;
    
    constructor() public {
        ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
        
        _games[_gameCount] = new Game(ref);
    }
    
    function getCurrentGameStartDate() public view returns (uint256) {
        return getCurrentGame().getCreationDate();
    }
    
    function getCurrentGameInitialValue() public view returns (uint256) {
        return getCurrentGame().getInitialValue();
    }
    
    function getCurrentGame() private view returns (Game) {
        return _games[_gameCount];
    }
    
    //Bitcoin price fetching
    function getLastBTCPrice() external view returns (uint256){
        IStdReference.ReferenceData memory data = ref.getReferenceData("BTC","USD");
        return data.rate;
    }

}