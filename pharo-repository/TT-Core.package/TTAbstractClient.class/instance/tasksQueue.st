accessing
tasksQueue
	^ tasksQueue ifNil: [ tasksQueue := SharedQueue new ]