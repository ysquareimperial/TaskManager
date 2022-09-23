// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract TaskManager {
    struct Task {
        string taskDescription;
        uint dateCreated;
        string taskStatus;
    }

    Task[] private tasks;
    Task[] private inProgressTasks;
    Task[] private completedTasks;

    //Function that creates tasks
    function createTask(string memory _taskDescription) public {
        tasks.push(
            Task({
                taskDescription: _taskDescription,
                dateCreated: block.timestamp,
                taskStatus: "pending"
            })
        );
    }

    //function that updates a task from pending to inprogress only when a task is pending
    function updateTaskStatusToInprogress(uint _index) public {
        require(
            keccak256(abi.encodePacked((tasks[_index].taskStatus))) ==
                keccak256(abi.encodePacked(("pending"))),
            "Task status must be pending to update it to inProgress"
        );

        tasks[_index].taskStatus = "inProgress";
        inProgressTasks.push(tasks[_index]);
    }

    //function that updates a task from inprogress to inprogress only when a task is inprogress.
    function updateTaskStatusToCompeleted(uint _index) public {
        require(
            keccak256(abi.encodePacked((tasks[_index].taskStatus))) ==
                keccak256(abi.encodePacked(("inProgress"))),
            "Task status must be inProgress to update it to completed"
        );

        tasks[_index].taskStatus = "completed";
        completedTasks.push(tasks[_index]);
        _updateInProgressTaskArray();
    }

    //function that stores inprogress tasks in an array called inProgressTasks.
    function _updateInProgressTaskArray() private {
        delete inProgressTasks;
        for (uint i = 0; i < tasks.length; i++) {
            if (
                (keccak256(abi.encodePacked((tasks[i].taskStatus))) ==
                    keccak256(abi.encodePacked(("inProgress"))))
            ) {
                inProgressTasks.push(tasks[i]);
            }
        }
    }

    //function to get all tasks.
    function getAllTask() public view returns (Task[] memory) {
        return tasks;
    }

    //function to get all inprogress tasks.
    function getAllInProgressTask() public view returns (Task[] memory) {
        return inProgressTasks;
    }

    //function to get all completed tasks.
    function getAllCompletedTask() public view returns (Task[] memory) {
        return completedTasks;
    }

    //function to get individual task through their index.
    function getIndividualTask(uint _index) public view returns (Task memory) {
        return tasks[_index];
    }
}
