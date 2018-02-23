accessing
tasksToExecute
	^ tasksToExecute ifNil: [ tasksToExecute := SharedQueue new ]