//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0;

import "@openzeppelin/contracts/proxy/Initializable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import '@uniswap/lib/contracts/libraries/TransferHelper.sol';
import "./interfaces/ITube.sol";
import "./interfaces/IWETH.sol";
import "./interfaces/ISwap.sol";
import "./utils/UniswapV2Library.sol";

contract Swap is ISwap, Initializable, Ownable {
  using SafeMath for uint;
  using SafeMath for uint256;

  modifier ensure(uint deadline) {
    require(deadline >= block.timestamp, "Swap::expired");
    _;
  }

  address public factory;
  address public WETH;
  ITube public tube;

  function initialize(
    address _weth,
    address _factory,
    ITube _tube
  ) public initializer {
    WETH = _weth;
    factory = _factory;
    tube = _tube;
  }

  function _swap(uint[] memory amounts, address[] memory path, address _to) private {
    for (uint i; i < path.length - 1; i++) {
      (address input, address output) = (path[i], path[i + 1]);
      (address token0,) = UniswapV2Library.sortTokens(input, output);
      uint amountOut = amounts[i + 1];
      (uint amount0Out, uint amount1Out) = input == token0 ? (uint(0), amountOut) : (amountOut, uint(0));
      address to = i < path.length - 2 ? UniswapV2Library.pairFor(factory, output, path[i + 2]) : _to;
      IUniswapV2Pair(UniswapV2Library.pairFor(factory, input, output)).swap(amount0Out, amount1Out, to, new bytes(0));
    }
  }

  function swap(
    uint amountIn,
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
  ) external payable override ensure(deadline) returns (uint iotx) {
    uint[] memory amounts;
    if (msg.value > 0) {
      require(path[0] == WETH, "Swap::swap::invalid path");
      amounts = UniswapV2Library.getAmountsOut(factory, msg.value, path);
      require(amounts[amounts.length - 1] >= amountOutMin, "Swap::swap::insufficient output amount");
      amountIn = msg.value;
      IWETH(WETH).deposit{value: msg.value}();
      assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]));
    } else {
      amounts = UniswapV2Library.getAmountsOut(factory, amountIn, path);
      require(amounts[amounts.length - 1] >= amountOutMin, "Swap::swap::insufficient output amount");
      amountIn = amounts[0];
      TransferHelper.safeTransferFrom(
        path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
      );
    }
    
    _swap(amounts, path, to);

    iotx = amounts[path.length - 1];
    
    tube.depositTo(to, iotx);

    emit Swaped(msg.sender, path[0], amountIn, iotx, to);
  }

  function quote(
    uint amountA,
    uint reserveA,
    uint reserveB
  ) public pure override returns (uint amountB) {
    return UniswapV2Library.quote(amountA, reserveA, reserveB);
  }

  function getAmountOut(
    uint amountIn,
    uint reserveIn,
    uint reserveOut
  ) public pure override returns (uint amountOut) {
    return UniswapV2Library.getAmountOut(amountIn, reserveIn, reserveOut);
  }

  function getAmountIn(
    uint amountOut,
    uint reserveIn,
    uint reserveOut
  ) public pure override returns (uint amountIn) {
    return UniswapV2Library.getAmountOut(amountOut, reserveIn, reserveOut);
  }

  function getAmountsOut(
    uint amountIn,
    address[] memory path
  ) public view override returns (uint[] memory amounts) {
    return UniswapV2Library.getAmountsOut(factory, amountIn, path);
  }

  function getAmountsIn(
    uint amountOut,
    address[] memory path
  ) public view override returns (uint[] memory amounts) {
    return UniswapV2Library.getAmountsIn(factory, amountOut, path);
  }

  function withdrawToken(
    address token,
    address to,
    uint256 amount
  ) external onlyOwner {
    TransferHelper.safeTransfer(token, to, amount);
  }

  function withdrawETH(
    address to,
    uint256 amount
  ) external onlyOwner {
    TransferHelper.safeTransferETH(to, amount);
  }
}
