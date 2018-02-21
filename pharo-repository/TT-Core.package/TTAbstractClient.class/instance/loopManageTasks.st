private-tasks
loopManageTasks
	[ self shouldLoopManageTasks ] whileTrue: [
		self manageTasks.
		self tasksManagementInterval wait.
	].
	self shutdown.