// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Token} from "../src/Token.sol";
import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract TokenTest is Test {
    Token public ourToken;
    DeployOurToken public deployer;

    address adam = makeAddr("adam");
    address joe = makeAddr("joe");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(adam, STARTING_BALANCE);
    }

    function testAdamBalance() public {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(adam));
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        vm.prank(adam);
        ourToken.approve(joe, initialAllowance);

        uint transferAmount = 500;
        vm.prank(joe);
        ourToken.transferFrom(adam, joe, transferAmount);

        assertEq(ourToken.balanceOf(joe), transferAmount);
        assertEq(ourToken.balanceOf(adam), (STARTING_BALANCE - transferAmount));
    }
}
