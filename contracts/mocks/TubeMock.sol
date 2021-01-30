// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "../interfaces/ITube.sol";

// mock class using ITube
contract TubeMock is ITube {
  event Deposited (
    address indexed to,
    uint256 amount
  );

  function depositTo(address _to, uint256 _amount) override external payable {
    emit Deposited(_to, _amount);
  }
}
