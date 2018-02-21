private
releaseProcesses
	self shouldLoopManageTasks: false.
	tasksManagementProcess ifNotNil: [
		tasksManagementProcess terminate.
		tasksManagementProcess := nil
	].