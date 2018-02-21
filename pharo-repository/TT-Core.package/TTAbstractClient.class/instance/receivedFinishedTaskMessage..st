private-tasks
receivedFinishedTaskMessage: msg
	self extractTaskMessage: msg body do: [ :producerCode :receivedTasks |
		producerCode = self uuid ifFalse: [ ^ nil ].
		Transcript logCr: ('Received finished tasks {1}' format: { ', ' join: receivedTasks }).
		receivedTasks collect: [ :receivedTask |
			| task |
			task := self taskAt: (receivedTask at: 'uuid').
			task result: (receivedTask at: 'result').
			task processResult.
		].
	].