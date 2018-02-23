private-processes
startProducerTaskManagementProcess
	producerTaskManagementProcess ifNotNil: [
		producerTaskManagementProcess isTerminating ifFalse: [ producerTaskManagementProcess terminate ]
	].
	self shouldLoopManageTasks: true.
	producerTaskManagementProcess := [ self loopManageProducerTasks ] newProcess.
	producerTaskManagementProcess priority: Processor userBackgroundPriority.
	producerTaskManagementProcess resume.