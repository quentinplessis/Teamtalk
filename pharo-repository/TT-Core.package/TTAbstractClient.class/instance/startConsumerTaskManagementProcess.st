private-processes
startConsumerTaskManagementProcess
	consumerTaskManagementProcess ifNotNil: [
		consumerTaskManagementProcess isTerminating ifFalse: [ consumerTaskManagementProcess terminate ]
	].
	self shouldLoopManageTasks: true.
	consumerTaskManagementProcess := [ self loopManageConsumerTasks ] newProcess.
	consumerTaskManagementProcess priority: Processor userBackgroundPriority.
	consumerTaskManagementProcess resume.