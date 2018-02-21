private-tasks
extractTaskMessage: json do: nextBlock
	| producerCode receivedTasks |
	
	producerCode := json at: 'producerCode' ifAbsent: [ ^ nil ].
	receivedTasks := json at: 'tasks' ifAbsent: [ { } ].
	
	nextBlock value: producerCode value: receivedTasks