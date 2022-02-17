// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "./utils/vm.sol";


interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

contract ContractTest is DSTest {
    function setUp() public {
        Vm vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
        address fee = 0xfEE0000000000000000000000000000000000000;
        bytes memory args = abi.encodePacked(fee);
        // bytes memory bytecode = abi.encodePacked(vm.getCode("UniswapV2Factory.sol:UniswapV2Factory.json"), args);
        // bytes memory bytecode = abi.encodePacked(vm.getCode("UniswapV2Factory"), args);
        // bytes memory bytecode = abi.encodePacked(vm.getCode("../uniswap-v2-core/out/UniswapV2Factory.sol/UniswapV2Factory.json"), args);
        bytes memory bytecode = abi.encodePacked(vm.getCode("out/UniswapV2Factory.sol/UniswapV2Factory.json"), args);
        address addr;
        assembly {
            addr := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        uint256 pairsLength = IUniswapV2Factory(addr).allPairsLength();
        emit log("allPairsLength:");
        emit log_uint(pairsLength);

    }

    function testExample() public {
        assertTrue(true);
    }
}
