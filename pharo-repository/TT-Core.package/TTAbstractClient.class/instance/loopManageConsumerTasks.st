private-processes
loopManageConsumerTasks
	[ self shouldLoopManageTasks ] whileTrue: [ self manageConsumerTasks. ].
	self shutdown.