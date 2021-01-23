//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/proxy/Initializable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./interfaces/ITube.sol";
import "./utils/Bytes.sol";

contract Swap is Initializable {
  using Bytes for bytes;
  using SafeMath for uint;

  address[] public path_iotx;
  address[] public path_usdt_iotx;
  IUniswapV2Router02 public router;
  ITube public tube;

  event Swaped(address indexed user, uint256 eth, uint256 iotx, address recipient);

  function initialize(
    address[] memory _path_iotx,
    address[] memory _path_usdt_iotx,
    IUniswapV2Router02 _router,
    ITube _tube
  ) public initializer {
    path_iotx = _path_iotx;
    path_usdt_iotx = _path_usdt_iotx;
    router = _router;
    tube = _tube;
  }

  fallback() external payable {
    uint256 _amountIn = msg.value;
    uint amount_iotx = router.getAmountsOut(_amountIn, path_iotx)[path_iotx.length - 1];
    uint amount_usdt_iotx = router.getAmountsOut(_amountIn, path_usdt_iotx)[path_usdt_iotx.length - 1];

    uint _deadline = block.timestamp + 1200;
    uint _uni_iotx;
    if (amount_iotx > amount_usdt_iotx) {
      _uni_iotx = router.swapETHForExactTokens(
        amount_iotx.sub(amount_iotx.mul(5).div(1000)),
        path_iotx,
        address(this),
        _deadline
      )[path_iotx.length - 1];
    } else {
      _uni_iotx = router.swapETHForExactTokens(
        amount_iotx.sub(amount_iotx.mul(5).div(1000)),
        path_usdt_iotx,
        address(this),
        _deadline
      )[path_usdt_iotx.length - 1];
    }
    
    address _to = msg.data.toAddress(0);
    tube.depositTo(_to, _uni_iotx);

    emit Swaped(msg.sender, _amountIn, _uni_iotx, _to);
  }

  receive() external payable {
    revert('must call fallback');
  }
}
