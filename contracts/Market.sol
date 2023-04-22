// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";



contract Market {
    address payable owner;

    IPoolAddressesProvider private immutable ADDRESSES_PROVIDER;
    IPool public immutable POOL;
    address private immutable poolAddress = 0xE7EC1B0015eb2ADEedb1B7f9F1Ce82F9DAD6dF08; // Pool-Proxy-Aave
    
    IERC20 private link;
    IERC20 private alink;
    address private immutable linkAddress = 0x8a0E31de20651fe58A369fD6f76c21A8FF7f8d42;
    address private immutable alinkAddress = 0xD21A6990E47a07574dD6a876f6B5557c990d5867;

    constructor(address _addressProvider) {
        ADDRESSES_PROVIDER = IPoolAddressesProvider(_addressProvider);
        POOL = IPool(ADDRESSES_PROVIDER.getPool());
        owner = payable(msg.sender);
        link = IERC20(linkAddress);
        alink = IERC20(alinkAddress);
    }
    // depositor
    function supplyLiquidity(address _tokenAddress, uint256 _amount) external {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address onBehalfOf = msg.sender; 
        uint16 referralCode = 0;

        IERC20 token = IERC20(_tokenAddress);
        uint256 allowance = token.allowance(msg.sender, poolAddress);
        require(allowance>=_amount, '"Check the token allowance"');

        POOL.supply(asset, amount, onBehalfOf, referralCode);
    }

    function withdrawLiquidity(address _tokenAddress, uint256 _amount) external onlyOwner returns (uint256) {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address to = msg.sender;

        return POOL.withdraw(asset, amount, to);
    }

    // Borrower
    function borrowFromLiquidity(address _tokenAddress, uint256 _amount, uint8 _interestRateMode) external {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        uint256 interestRateMode = _interestRateMode; // 1 for Stable, 2 for Variable
        uint16 referralCode = 0;
        address onBehalfOf = msg.sender;

        POOL.borrow(asset, amount, interestRateMode, referralCode, onBehalfOf);
    }

    function repaytoLiquidity(address _tokenAddress, uint256 _amount, uint8 _interestRateMode) external {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        uint256 interestRateMode = _interestRateMode; // 1 for Stable, 2 for Variable
        uint16 referralCode = 0;
        address onBehalfOf = msg.sender;

        POOL.borrow(asset, amount, interestRateMode, referralCode, onBehalfOf);
    }



    // Returns the user account data across all the reserves
    function getUserAccountData(address _userAddress)
        external
        view
        returns (
            // The total collateral of the user in the base currency used by the price feed
            uint256 totalCollateralBase, 
            // The total debt of the user in the base currency used by the price feed
            uint256 totalDebtBase,
            // The borrowing power left of the user in the base currency used by the price feed
            uint256 availableBorrowsBase,
            // The liquidation threshold of the user
            uint256 currentLiquidationThreshold,
            // The loan to value of The user
            uint256 ltv,
            // The current health factor of the user
            uint256 healthFactor
        )
    {
        return POOL.getUserAccountData(_userAddress);
    }


    function allowancetoken(address _tokenAddress) external view returns (uint256){
        IERC20 token = IERC20(_tokenAddress);
        return token.allowance(msg.sender, poolAddress);
    }

    function getBalancetoken(address _tokenAddress) external view returns (uint256) {
        IERC20 token = IERC20(_tokenAddress);
        return token.balanceOf(msg.sender);
    }

    function getBalanceAtoken(address _atokenAddress) external view returns (uint256) {
        IERC20 atoken = IERC20(_atokenAddress);
        return atoken.balanceOf(msg.sender);
    }

    function getBalanceLink() external view returns (uint256) {
        return link.balanceOf(msg.sender);
    }

    function getBalanceALink() external view returns (uint256) {
        return alink.balanceOf(msg.sender);
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