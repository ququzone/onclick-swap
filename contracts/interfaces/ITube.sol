//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.0;

interface ITube {
  function depositTo(address _to, uint256 _amount) external payable;
}
