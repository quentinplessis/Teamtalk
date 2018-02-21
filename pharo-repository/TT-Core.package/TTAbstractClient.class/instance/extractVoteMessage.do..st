private-tasks
extractVoteMessage: json do: nextBlock
	| producerCode workerCode receivedVotes |
	
	producerCode := json at: 'producerCode' ifAbsent: [ ^ nil ].
	producerCode = self uuid ifFalse: [ ^ nil ].
	workerCode := json at: 'workerCode' ifAbsent: [ ^ nil ].
	
	receivedVotes := json at: 'votes' ifAbsent: [ { } ].
	
	nextBlock value: workerCode value: receivedVotes.