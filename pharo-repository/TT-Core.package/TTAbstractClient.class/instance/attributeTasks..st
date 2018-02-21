private-tasks
attributeTasks: tasksToAttribute
	tasksToAttribute ifEmpty: [ ^ nil ].
	Transcript logCr: ('Attribute tasks {1}' format: { ', ' join: tasksToAttribute }).
	tasksToAttribute do: [ :task | task attribute. ].
	self eventBus publish: {
		'producerCode' -> (self uuid).
		'tasks' -> tasksToAttribute.
	} to: (self defaultAttributedTasksAddress).