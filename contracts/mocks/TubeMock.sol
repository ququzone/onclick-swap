// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/ITube.sol";

// mock class using ITube
contract TubeMock is ITube {
  address public iotx;

  constructor (
    address _iotx
  ) public {
    iotx = _iotx;
  }

  event Deposited (
    address indexed to,
    uint256 amount
  );

  function depositTo(address _to, uint256 _amount) override external payable {
    require(IERC20(iotx).transferFrom(msg.sender, address(this), _amount), "TubeMock::depositTo::transfer iotx fail");
    emit Deposited(_to, _amount);
  }
}
