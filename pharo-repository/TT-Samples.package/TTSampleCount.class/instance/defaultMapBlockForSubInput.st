defaults
defaultMapBlockForSubInput
	^ [ :subInput |
		| min max |
		min := subInput at: 'min'.
		max := subInput at: 'max'.
		(min to: max) inject: 0 into: [ :sum :i | sum + i ]
	]