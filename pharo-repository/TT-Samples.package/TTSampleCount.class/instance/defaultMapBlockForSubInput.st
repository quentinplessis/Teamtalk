defaults
defaultMapBlockForSubInput
	^ [ :subInput | 
		'[
			({1} to: {2}) inject: 0 into: [ :sum :i | sum + i ].
		]' format: {
			(subInput at: 'min').
			(subInput at: 'max').
		}
	]