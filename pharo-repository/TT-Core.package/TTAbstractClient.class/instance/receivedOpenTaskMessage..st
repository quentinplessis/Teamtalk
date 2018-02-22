private-tasks
receivedOpenTaskMessage: msg
	self extractTaskMessage: msg body do: [ :producerCode :receivedTasks |
		| votes |
		votes := receivedTasks shuffle collect: [ :task |
			| vote |
			vote := self generateVoteForTask: task.
			self addConsideredTask: task.
			vote
		].
		Transcript logCr: ('Send votes {1}' format: { ', ' join: votes }).
		self eventBus publish: {
			'producerCode' -> producerCode.
			'workerCode' -> (self uuid).
			'votes' -> votes.
		} to: (self defaultVotesAddress)
	].