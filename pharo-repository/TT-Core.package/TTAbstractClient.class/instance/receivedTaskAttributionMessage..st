private-tasks-consumer
receivedTaskAttributionMessage: msg
	| task |
	task := TTTask from: msg body.
	task workerCode = self uuid ifFalse: [ ^ nil ].
	self tasksToExecute nextPut: task.
	self log: ('Received attributed task {1}' format: { task description })