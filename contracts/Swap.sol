//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/proxy/Initializable.sol";

contract Swap is Initializable {
  address[] public path_iotx;
  address[] public path_usdt_iotx;
  address public router;
  address public tube;

  event Swaped(address indexed user, uint256 eth, bytes ioAddress);

  function initialize(
    address[] memory _path_iotx,
    address[] memory _path_usdt_iotx,
    address _router,
    address _tube
  ) public initializer {
    path_iotx = _path_iotx;
    path_usdt_iotx = _path_usdt_iotx;
    router = _router;
    tube = _tube;
  }

  fallback() external payable {
    emit Swaped(msg.sender, msg.value, msg.data);
  }

  receive() external payable {
    revert('must call fallback');
  }
}
