accessing
resultsQueue
	^ resultsQueue ifNil: [ resultsQueue := SharedQueue new ]