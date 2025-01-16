// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console, stdError } from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import { Helper } from "./Helper.sol";

contract CounterTest is Test, Helper {
    Counter public counter;

    event Incremented(uint indexed number, address indexed sender);

    function setUp() public {
        counter = new Counter();
        counter.setNumber(11);
    }

    function testFailSubstraction() public view {
        uint number = counter.number();
        number -= 1000;
    }
    function testSubstractionUnderflow() public {
        uint number = counter.number();
        vm.expectRevert(stdError.arithmeticError);
        number -= 1000;
    }

    function test_Increment() public {
        vm.expectEmit(true, true, true, false);

        emit Incremented(12, address(this));

        counter.increment();
        assertEq(counter.number(), 12);
    }

    function test_Increment_withErr() public {
        vm.prank(address(0));
        vm.expectRevert(bytes("not an owner"));
        counter.increment();
        assertEq(counter.number(), 11);
    }
    function testFail_Increment() public {
        vm.prank(address(0));
        counter.increment();
        assertEq(counter.number(), 14);
    }

    function test_Owner() public {
        assertEq(counter.owner(), address(this));
    }

    function test_SetNumber() public {
        counter.setNumber(testNum);
        console.log(testNum);
        assertEq(counter.number(), testNum);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        console.log(x);
        assertEq(counter.number(), x);
    }
}
