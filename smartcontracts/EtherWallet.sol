//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC20 {
    function transfer(address _to, uint256 _amount) external returns (bool);
}

contract EtherWallet {

    // Definite owner contract, which is a payable address
    address payable public owner;

    constructor() {
        // Initialization: the address of deployed contract, set it as owner
        owner = payable(msg.sender);
    }

    // receive function, we using it to receive ETH.
    receive() external payable{}

    // Withdraw ETH, Only owner can withdraw ETH
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    // Querying the balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function withdrawToken(address _tokenContract, uint256 _amount) external {
        IERC20 tokenContract = IERC20(_tokenContract);

        //transfer the token from address of this contract
        // to address of the user (excuting the withdrawToken() function)
        tokenContract.transfer(msg.sender, _amount);

    }

}