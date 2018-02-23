private-tasks-producer
receivedExecutedTaskMessage: msg
	| receivedTask task |
	receivedTask := TTTask from: msg body.
	receivedTask producerCode = self uuid ifFalse: [ ^ nil ].
	task := self allTasks at: receivedTask uuid ifAbsent: [ ^ nil ].
	task result: receivedTask result.
	self log: ('Received executed task {1}' format: { task description }).
	task processResult.