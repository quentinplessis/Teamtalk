defaults
defaultMapBlockForSubInput
	^ [ :subInput | 
		'[
			(({1} to: {2}) select: [ :i | {3} % i = 0 ]) collect: [ :i | \{ i. {3} / i \} ].
		]' format: {
			(subInput at: 'min').
			(subInput at: 'max').
			(subInput at: 'number')
		}
	]