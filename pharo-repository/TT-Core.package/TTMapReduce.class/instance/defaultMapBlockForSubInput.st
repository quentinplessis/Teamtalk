defaults
defaultMapBlockForSubInput
	^ [ :subInput | 
		'[ {1} ]' format: { subInput }
	]