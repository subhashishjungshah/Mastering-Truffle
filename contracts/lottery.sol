// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Lottery {
    //  This is the one who deploys this contract
    address public manager;

    // This are the participants
    address payable[] public participants;

    constructor() {
        manager = msg.sender; // msg.sender is the one who deploys this address
    }

    // This can be used only one time. It can be called using transact function

    receive() external payable {
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns (uint) {
        require(msg.sender == manager);
        return address(this).balance;
    }

    function random() public view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.prevrandao,
                        block.timestamp,
                        participants.length
                    )
                )
            );
    }

    function selectWinner() public {
        require(msg.sender == manager);
        require(participants.length >= 3);

        uint r = random();

        address payable winner;

        uint index = r % participants.length;

        winner = participants[index];

        winner.transfer(getBalance());

        participants = new address payable[](0);
    }
}
