private-tasks
startTaskManagementProcess
	taskManagementProcess ifNotNil: [
		taskManagementProcess isTerminating ifFalse: [ taskManagementProcess terminate ]
	].
	self shouldLoopManageTasks: true.
	taskManagementProcess := [ self loopManageTasks ] newProcess.
	taskManagementProcess priority: Processor userBackgroundPriority.
	taskManagementProcess resume.