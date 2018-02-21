private-tasks
receivedVoteMessage: msg
	self extractVoteMessage: msg body do: [ :workerCode :votes |
		Transcript logCr: ('Received votes {1}' format: { ', ' join: votes }).
		self extractVotes: votes do: [ :taskUUID :score |
			| task |
			task := (self taskAt: taskUUID).
			task addVote: score workerCode: workerCode.
		].
	].
	