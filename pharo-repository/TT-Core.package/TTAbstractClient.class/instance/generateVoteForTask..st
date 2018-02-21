private-tasks
generateVoteForTask: task
	^ { 
		'uuid' -> (task at: #uuid).
		'vote' -> (self newVote).
	} asDictionary