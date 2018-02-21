actions
addVote: vote workerCode: workerCode
	^ self votes add: { 
		'vote' -> vote.
		'workerCode' -> workerCode.
	} asDictionary