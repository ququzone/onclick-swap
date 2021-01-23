//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.2;

import "../interfaces/IUniswapV2Router02.sol";

contract MockUniswapV2Router02 is IUniswapV2Router02 {
    address public immutable override factory;
    address public immutable override WETH;

    constructor(address _factory, address _WETH) public {
        factory = _factory;
        WETH = _WETH;
    }

    function addLiquidity(
      address tokenA,
      address tokenB,
      uint256 amountADesired,
      uint256 amountBDesired,
      uint256 amountAMin,
      uint256 amountBMin,
      address to,
      uint256 deadline
    ) external virtual override returns (
        uint256 amountA,
        uint256 amountB,
        uint256 liquidity
      )
    {}

    function addLiquidityETH(
      address token,
      uint256 amountTokenDesired,
      uint256 amountTokenMin,
      uint256 amountETHMin,
      address to,
      uint256 deadline
    ) external virtual override payable
      returns (
        uint256 amountToken,
        uint256 amountETH,
        uint256 liquidity
      )
    {}

    function removeLiquidity(
      address tokenA,
      address tokenB,
      uint256 liquidity,
      uint256 amountAMin,
      uint256 amountBMin,
      address to,
      uint256 deadline
    ) public virtual override returns (uint256 amountA, uint256 amountB) {}

    function removeLiquidityETH(
      address token,
      uint256 liquidity,
      uint256 amountTokenMin,
      uint256 amountETHMin,
      address to,
      uint256 deadline
    ) public virtual override returns (uint256 amountToken, uint256 amountETH){

    }

    function removeLiquidityWithPermit(
      address tokenA,
      address tokenB,
      uint256 liquidity,
      uint256 amountAMin,
      uint256 amountBMin,
      address to,
      uint256 deadline,
      bool approveMax,
      uint8 v,
      bytes32 r,
      bytes32 s
    ) external virtual override returns (uint256 amountA, uint256 amountB) {}

    function removeLiquidityETHWithPermit(
      address token,
      uint256 liquidity,
      uint256 amountTokenMin,
      uint256 amountETHMin,
      address to,
      uint256 deadline,
      bool approveMax,
      uint8 v,
      bytes32 r,
      bytes32 s
    ) external virtual override returns (uint256 amountToken, uint256 amountETH) {
    }

    function removeLiquidityETHSupportingFeeOnTransferTokens(
      address token,
      uint256 liquidity,
      uint256 amountTokenMin,
      uint256 amountETHMin,
      address to,
      uint256 deadline
    ) public virtual override returns (uint256 amountETH) {
    }

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
      address token,
      uint256 liquidity,
      uint256 amountTokenMin,
      uint256 amountETHMin,
      address to,
      uint256 deadline,
      bool approveMax,
      uint8 v,
      bytes32 r,
      bytes32 s
    ) external virtual override returns (uint256 amountETH) {
    }

    function swapExactTokensForTokens(
      uint256 amountIn,
      uint256 amountOutMin,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override returns (uint256[] memory amounts) {
    }

    function swapTokensForExactTokens(
      uint256 amountOut,
      uint256 amountInMax,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override returns (uint256[] memory amounts) {
    }

    function swapExactETHForTokens(
      uint256 amountOutMin,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override payable returns (uint256[] memory amounts) {
    }

    function swapTokensForExactETH(
      uint256 amountOut,
      uint256 amountInMax,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override returns (uint256[] memory amounts) {
    }

    function swapExactTokensForETH(
      uint256 amountIn,
      uint256 amountOutMin,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override returns (uint256[] memory amounts) {
    }

    function swapETHForExactTokens(
      uint256 amountOut,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override payable returns (uint256[] memory amounts) {
    }

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
      uint256 amountIn,
      uint256 amountOutMin,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override {
    }

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
      uint256 amountOutMin,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override payable {
    }

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
      uint256 amountIn,
      uint256 amountOutMin,
      address[] calldata path,
      address to,
      uint256 deadline
    ) external virtual override {
    }

    function quote(
      uint256 amountA,
      uint256 reserveA,
      uint256 reserveB
    ) public virtual override pure returns (uint256 amountB) {
    }

    function getAmountOut(
      uint256 amountIn,
      uint256 reserveIn,
      uint256 reserveOut
    ) public virtual override pure returns (uint256 amountOut) {
    }

    function getAmountIn(
      uint256 amountOut,
      uint256 reserveIn,
      uint256 reserveOut
    ) public virtual override pure returns (uint256 amountIn) {
    }

    function getAmountsOut(uint256 amountIn, address[] memory path)
      public virtual override view returns (uint256[] memory amounts) {
    }

    function getAmountsIn(uint256 amountOut, address[] memory path)
      public virtual override view returns (uint256[] memory amounts) {
    }
}
