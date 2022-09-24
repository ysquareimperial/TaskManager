// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


contract TaskManager{

    
    struct task {
        string taskDescription;
        uint dateCreated;
        string taskStatus;
    }

    
    task[] private tasks;
    task[] private inProgressTasks;
    task[] private completedTasks;
    task[] private pendingTasks;
    
    
    //Function that creates tasks
    function createTask(string memory _taskDescription) public {
        tasks.push(task({taskDescription : _taskDescription, dateCreated: block.timestamp, taskStatus : "pending"}));
    }

    //function that updates a task from pending to inprogress only when a task is pending
    function updateTaskStatusToInprogress (uint _index) public {
        if((keccak256(abi.encodePacked((tasks[_index].taskStatus))) == keccak256(abi.encodePacked(("pending"))))){
            tasks[_index].taskStatus = "inProgress";
        }
    }



    //function that updates a task from inprogress to completed only when a task is inprogress.
    function updateTaskStatusToCompeleted (uint _index) public {
        if((keccak256(abi.encodePacked((tasks[_index].taskStatus))) == keccak256(abi.encodePacked(("inProgress"))))){
            tasks[_index].taskStatus = "completed";
        }
        
    }

    //function that stores inprogress tasks in an array called inProgressTasks.  
    function updateInProgressTaskArray( ) public payable {
        for (uint i = 0; i < tasks.length; i++) {
        if((keccak256(abi.encodePacked((tasks[i].taskStatus))) == keccak256(abi.encodePacked(("inProgress"))))){
              inProgressTasks.push(
                  tasks[i]
              );
            }
            
        }
    }

    //function that stores completed tasks in an array called completedTasks.
    function updateCompletedTaskArray( ) public {
        for (uint i = 0; i < tasks.length; i++) {
        if((keccak256(abi.encodePacked((tasks[i].taskStatus))) == keccak256(abi.encodePacked(("completed"))))){
              completedTasks.push(
                  tasks[i]
              );
            }
            
        }
    }

    //function to get all tasks.
    function getAllTask() public view returns (task[] memory) {
        return tasks;
    }

    //function to get all inprogress tasks.
    function getAllInProgressTask() public view returns (task[] memory) {
        return inProgressTasks;
    }

    //function to get all completed tasks.
    function getAllCompletedTask() public view returns (task[] memory) {
        return completedTasks;
    }

    
    //function to get individual task through their index.
    function getIndividualTask(uint _index) public view returns(task memory)
    {
        return tasks[_index];
    }

    
//function that updates the pending task array.
    function updatePendingTaskArray() public {
        delete pendingTasks;

        for (uint i = 0; i < tasks.length; i++) {
            if (
                (keccak256(abi.encodePacked((tasks[i].taskStatus))) ==
                    keccak256(abi.encodePacked(("pending"))))
            ) {
                pendingTasks.push(tasks[i]);
            }
        }
    }

//function that gets all pending tasks.
    function getAllPendingTasks() public view returns (task[] memory) {
        return pendingTasks;
        
    }

//function to delete a task.
function deleteTask (uint _index) public {
    delete tasks[_index];
}



}