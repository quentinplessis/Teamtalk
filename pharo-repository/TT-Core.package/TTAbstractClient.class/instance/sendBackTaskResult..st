private-tasks-consumer
sendBackTaskResult: executedTask
	self eventBus publish: executedTask to: (self defaultExecutedTasksAddress).
	self log: ('Executed task {1}' format: { executedTask description })