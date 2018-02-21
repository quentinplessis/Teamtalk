accessing
tasksManagementInterval
	^ tasksManagementInterval ifNil: [ tasksManagementInterval := self defaultTasksManagementInterval ]