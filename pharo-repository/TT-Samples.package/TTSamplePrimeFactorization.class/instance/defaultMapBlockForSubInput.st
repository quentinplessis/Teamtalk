defaults
defaultMapBlockForSubInput
	^ [ :subInput |
		| min max number |
		min := subInput at: 'min'.
		max := subInput at: 'max'.
		number := subInput at: 'number'.
		((min to: max) select: [ :i | number % i = 0 ]) collect: [ :i | { i. number / i } ]
	]