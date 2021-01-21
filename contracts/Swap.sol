//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

contract Swap {
  bytes public data;

  event Swaped(address indexed user, uint256 eth, bytes ioAddress);

  fallback() external payable {
    data = msg.data;
    emit Swaped(msg.sender, msg.value, msg.data);
  }

  receive() external payable {
    revert('must call fallback');
  }
}
