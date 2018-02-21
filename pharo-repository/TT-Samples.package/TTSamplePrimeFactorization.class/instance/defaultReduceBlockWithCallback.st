defaults
defaultReduceBlockWithCallback
	^ [ :results :callback |
		| factors |
		factors := results detect: [ :r | r isNotEmpty ].
		callback value: factors
	]