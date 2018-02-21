defaults
defaultReduceBlockWithCallback
	^ [ :results :callback |
		| sum |
		sum := results inject: 0 into: [ :s :r | s + r ].
		callback value: sum
	]