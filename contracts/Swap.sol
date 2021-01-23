//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/proxy/Initializable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import '@uniswap/lib/contracts/libraries/TransferHelper.sol';
import "./interfaces/IUniswapV2Router02.sol";
import "./interfaces/ITube.sol";
import "./interfaces/IWETH.sol";

contract Swap is Initializable, Ownable {
  using SafeMath for uint;
  using SafeMath for uint256;

  address public WETH;
  IUniswapV2Router02 public router;
  ITube public tube;

  event Swaped(
    address indexed user,
    address token,
    uint256 amountIn,
    uint256 amountOut,
    address recipient
  );

  function initialize(
    address _weth,
    IUniswapV2Router02 _router,
    ITube _tube
  ) public initializer {
    WETH = _weth;
    router = _router;
    tube = _tube;
  }

  function swap(
    uint amountIn,
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
  ) external payable {
    if (msg.value > 0) {
      require(path[0] == WETH, "Swap::swap::invalid path");
      require(amountIn >= msg.value, "Swap::swap::invalid amount in");
      IWETH(WETH).deposit{value: msg.value}();
      uint[] memory amounts = router.getAmountsOut(amountIn, path);
      require(amounts[amounts.length - 1] >= amountOutMin, "Swap::swap::insufficient output amount");
      if (amounts[0] > msg.value) {
        TransferHelper.safeTransferFrom(
          WETH, msg.sender, address(this), amounts[0].sub(msg.value)
        );
      }
    } else {
      uint requireAmount = router.getAmountsOut(amountIn, path)[0];
      TransferHelper.safeTransferFrom(
        path[0], msg.sender, address(this), requireAmount
      );
    }
    
    uint[] memory amounts = router.swapExactTokensForTokens(
      amountIn,
      amountOutMin,
      path,
      address(this),
      deadline
    );
    
    tube.depositTo(to, amounts[path.length - 1]);
    if (msg.value > amounts[0]) {
      TransferHelper.safeTransfer(WETH, msg.sender, msg.value.sub(amounts[0]));
    }

    emit Swaped(msg.sender, path[0], amounts[0], amounts[path.length - 1], to);
  }

  function withdrawWETH(address to, uint256 amount) external onlyOwner {
    TransferHelper.safeTransfer(WETH, to, amount);
  }

  function withdrawETH(address to, uint256 amount) external onlyOwner {
    TransferHelper.safeTransferETH(to, amount);
  }
}
