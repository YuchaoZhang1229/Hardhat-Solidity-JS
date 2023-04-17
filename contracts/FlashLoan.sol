// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol"; // interface
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract FlashLoan is FlashLoanSimpleReceiverBase {
    address payable owner; //调用这个合约的人

    // Aave ERC20 Token addresses on Sepolia network
    address private immutable daiAddress =
        0x68194a729C2450ad26072b3D33ADaCbcef39D574;
    address private immutable usdcAddress =
        0xda9d4f9b69ac6C22e444eD9aF0CfC043b7a7f53f;


    IERC20 private dai;
    IERC20 private usdc;

    constructor(address _addressProvider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider))
    {
        owner = payable(msg.sender);
        dai = IERC20(daiAddress);
        usdc = IERC20(usdcAddress);
    }

    function executeOperation(
        address asset, //  The address of the flash-borrowed asset
        uint256 amount, // The amount of the flash-borrowed asset
        uint256 premium, // The fee of the flash-borrowed asset
        address initiator, // The address of the flashloan initiator
        bytes calldata params // The byte-encoded params passed when initiating the flashloan
        // return-True if the execution of the operation succeeds, false otherwise
        ) external override returns (bool) {
            // we have the borrowed funds
            // custom logic such as arbitrage
            uint256 amountOwed = amount + premium;
            IERC20(asset).approve(address(POOL),amountOwed); // POOL在接口里
            return true;
        }

    function requestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this); // 接收flash loan的地址
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        POOL.flashLoanSimple (
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
            );
    }

    // use it after flash loan is completed just to see the balance of our contact
    // 输入货币地址返回余额
    function getBalance(address _tokenaddress) external view returns (uint256) {
        return IERC20(_tokenaddress).balanceOf(address(this));
    }
    // 输入货币地址提取货币到自己的账户
    // want a way to withdraw out profit after the flash loan is done 
    function withdraw(address _tokenaddress) external onlyOwner{
        IERC20 token = IERC20(_tokenaddress);
        token.transfer(msg.sender,token.balanceOf(address(this)));
    } 


    // DAI
    function getBalanceDAI() external view returns (uint256) {
        return dai.balanceOf(address(this));
    }

    function approveDAI(uint256 _amount) external returns (bool) {
        return dai.approve(msg.sender, _amount);
    }

    function allowanceDAI() external view returns (uint256) {
        return dai.allowance(address(this), msg.sender);
    }

    function depositDAI(uint256 _amount) external {
        uint256 allowance = usdc.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Check the token allowance");
        dai.transferFrom(msg.sender, address(this), _amount);
    }

    function withdrawDAI() external onlyOwner{
        dai.transfer(msg.sender, dai.balanceOf(address(this)));
    } 




    // USDC

    function getBalanceUSDC() external view returns (uint256) {
        return usdc.balanceOf(address(this));
    }

    function approveUSDC(uint256 _amount) external returns (bool) {
        return usdc.approve(msg.sender, _amount);
    }

    function allowanceUSDC() external view returns (uint256) {
        return usdc.allowance(address(this), msg.sender);
    }

    function depositUSDC(uint256 _amount) external {
        uint256 allowance = usdc.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Check the token allowance");
        usdc.transferFrom(msg.sender, address(this), _amount);
    }

    function withdrawUSDC() external onlyOwner{
        usdc.transfer(msg.sender, usdc.balanceOf(address(this)));
    } 



    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    receive() external payable {}
}