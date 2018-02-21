private-tasks
extractVotes: votes do: nextBlock
	votes do: [ :vote |
		| taskUUID score |
		taskUUID := vote at: 'uuid' ifAbsent: [ ].
		score := vote at: 'vote' ifAbsent: [ ].
		(taskUUID notNil and: [ score notNil ]) ifTrue: [ 
			nextBlock value: taskUUID value: score
		].
	]. 
	