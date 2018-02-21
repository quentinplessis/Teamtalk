defaults
defaultReduceBlockWithCallback
	^ [ :results :callback |
		callback value: results
	]