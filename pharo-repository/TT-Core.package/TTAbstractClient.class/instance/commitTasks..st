private-tasks
commitTasks: tasksToCommit
	tasksToCommit ifEmpty: [ ^ nil ].
	Transcript logCr: ('Commit tasks {1}' format: { ', ' join: tasksToCommit }).
	tasksToCommit do: [ :task | task commit. ].
	self eventBus publish: {
		'producerCode' -> (self uuid).
		'tasks' -> tasksToCommit.
	} to: (self defaultOpenTasksAddress).