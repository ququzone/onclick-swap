// SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/ITube.sol";

// mock class using ITube
contract TubeMock is ITube {
  event Deposited (
    address indexed token,
    address indexed to,
    uint256 amount
  );

  function depositTo(address _token, address _to, uint256 _amount) override external payable {
    require(IERC20(_token).transferFrom(msg.sender, address(this), _amount), "TubeMock::depositTo::transfer token fail");
    emit Deposited(_token, _to, _amount);
  }

  function depositFee() override external view returns (uint256) {
    return 0;
  }
}
