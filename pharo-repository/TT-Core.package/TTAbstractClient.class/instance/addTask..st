actions
addTask: task
	self isProducer ifFalse: [ ^ nil ].
	self allTasks at: task uuid put: task.
	self tasksQueue nextPut: task.