private-processes
releaseProcesses
	self shouldLoopManageTasks: false.
	producerTaskManagementProcess ifNotNil: [
		producerTaskManagementProcess terminate.
		producerTaskManagementProcess := nil
	].
	consumerTaskManagementProcess ifNotNil: [
		consumerTaskManagementProcess terminate.
		consumerTaskManagementProcess := nil
	].