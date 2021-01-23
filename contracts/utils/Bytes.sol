//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.2;

library Bytes {
  function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_start + 20 >= _start, "Bytes::toAddress::overflow");
    require(_bytes.length >= _start + 20, "Bytes::toAddress::out of bounds");

    address _address;
    assembly {
      _address := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }

    return _address;
  }
}