private-processes
loopManageProducerTasks
	[ self shouldLoopManageTasks ] whileTrue: [ self manageProducerTasks. ].
	self shutdown.