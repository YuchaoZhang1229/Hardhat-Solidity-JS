// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// IPool interface which contains all the methods that we'll need like supply, withdrawak, request flash loan, etc
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol"; 
// IPoolAddressesProvider will give us back the actual address of the poll it's just an abstraction layer
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
// IERC20 is needed in order to pre-approve the withdrawal or the transfer of ERC20 tokens that we'll use to supply to the AAve pool
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract MarketInteractions {
    address payable owner;

    IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
    IPool public immutable POOL;

    address payable private immutable  linkAddress =
        payable(0xda9d4f9b69ac6C22e444eD9aF0CfC043b7a7f53f);
    IERC20 private link;
    IERC20 private tokenType;

    constructor(address _addressProvider) {
        ADDRESSES_PROVIDER = IPoolAddressesProvider(_addressProvider);
        POOL = IPool(ADDRESSES_PROVIDER.getPool());
        owner = payable(msg.sender);
        link = IERC20(linkAddress); // can make the token dynamic by including a setus different tokens and set them beform each transactionter function so that we can pass in the address of vario
    }

    function setTokenAddress(address _tokenAddress) public{
        tokenType = IERC20(_tokenAddress);
    }

    // interact with the pool
    // suppy-   wallet → pool
    // Supplies an `amount` of underlying asset into the reserve, receiving in return overlying aTokens.
    function supplyLiquidity(address _tokenAddress, uint256 _amount) 
    external {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address onBehalfOf = address(this);
        uint16 referralCode = 0;

        POOL.supply(asset, amount, onBehalfOf, referralCode);
    }

    // Withdraws an `amount` of underlying asset from the reserve, burning the equivalent aTokens owned
    function withdrawlLiquidity(address _tokenAddress, uint256 _amount) 
    external
    returns (uint256)
    {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address to = address(this);

        return POOL.withdraw(asset, amount, to);
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



    // aproove and allowance-allow us to pre-approve a transfer to the aave protocol
    function approveLINK(uint256 _amount, address _poolContractAddress)
        external
        returns (bool)
    {
        return link.approve(_poolContractAddress, _amount);
    }

    function allowanceLINK(address _poolContractAddress)
        external
        view
        returns (uint256)
    {
        return link.allowance(address(this), _poolContractAddress);
    }

    // check what the balance of the contract is for any given token
    function getBalance(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    // withdraw those funds back from the contract to wallet
    function withdraw(address _tokenAddress) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
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