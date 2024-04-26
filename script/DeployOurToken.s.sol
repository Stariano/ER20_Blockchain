// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract DeployOurToken is Script {
    uint256 public constant INITAL_SUPPLY = 1000 ether;

    function run() external returns (Token) {
        vm.startBroadcast();
        Token newToken = new Token(INITAL_SUPPLY);
        vm.stopBroadcast();
        return newToken;
    }
}
