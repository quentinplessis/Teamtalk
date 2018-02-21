private-tasks
receivedOpenTaskMessage: msg
	self extractTaskMessage: msg body do: [ :producerCode :receivedTasks |
		| votes |
		votes := receivedTasks collect: [ :task |
			self generateVoteForTask: task.
		].
		Transcript logCr: ('Send votes {1}' format: { ', ' join: votes }).
		self eventBus publish: {
			'producerCode' -> producerCode.
			'workerCode' -> (self uuid).
			'votes' -> votes.
		} to: (self defaultVotesAddress)
	].