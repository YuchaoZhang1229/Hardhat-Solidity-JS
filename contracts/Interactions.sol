// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract Interactions {
    address payable owner;

    IPoolAddressesProvider private immutable ADDRESSES_PROVIDER;
    IPool public immutable POOL;

    address private immutable linkAddress = 0x8a0E31de20651fe58A369fD6f76c21A8FF7f8d42;
    address private immutable alinkAddress = 0xD21A6990E47a07574dD6a876f6B5557c990d5867;
    address private immutable poolAddress = 0xE7EC1B0015eb2ADEedb1B7f9F1Ce82F9DAD6dF08; // Pool-Proxy-Aave
    IERC20 private link;
    IERC20 private alink;

    constructor(address _addressProvider) {
        ADDRESSES_PROVIDER = IPoolAddressesProvider(_addressProvider);
        POOL = IPool(ADDRESSES_PROVIDER.getPool());
        owner = payable(msg.sender);
        link = IERC20(linkAddress);
        alink = IERC20(alinkAddress);
    }

    function supplyLiquidityLINK(uint256 _amount) external {
        address asset = linkAddress;
        uint256 amount = _amount;
        address onBehalfOf = address(this); 
        uint16 referralCode = 0;

        // 该合约中的link到pool
        link.approve(poolAddress, _amount); 
        POOL.supply(asset, amount, onBehalfOf, referralCode);
    }

    function withdrawlLiquidity(uint256 _amount) external returns (uint256) {
        address asset = linkAddress;
        uint256 amount = _amount;
        address to = address(this);

        return POOL.withdraw(asset, amount, to);
    }


    function depositLink(uint256 _amount) external {
        link.transferFrom(msg.sender, address(this), _amount );
    }

    function approveLINKtoPool(uint256 _amount) external returns (bool){
        return link.approve(poolAddress, _amount); // 允许该合约可以发送link的数量   this address to Spender
    }

    function allowanceLINKtoPool() external view returns (uint256) {
        return link.allowance(address(this), poolAddress); // Owner, Spender
    }

    function getBalanceLINK() external view returns (uint256) {
        return link.balanceOf(address(this));
    }

    function getBalanceALINK() external view returns (uint256) {
        return alink.balanceOf(address(this));
    }

    function LINKWallet() external view returns (uint256) {
        return link.balanceOf(msg.sender);
    }

    function withdrawLINK() external onlyOwner {
        link.transfer(msg.sender, link.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can call this function"
        );
        _;
    }

    receive() external payable {}
}