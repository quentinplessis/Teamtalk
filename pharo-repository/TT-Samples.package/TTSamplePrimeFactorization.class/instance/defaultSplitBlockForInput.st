defaults
defaultSplitBlockForInput
	^ [ :number :tasksNumber |
		| min max delta |
	
		min := 2.
		max := number sqrt floor.
		delta := ((max-min) / tasksNumber) ceiling.
		delta = 0 ifTrue: [ delta := 1 ].
	
		(min to: (max-1) by: delta) collect: [ :i |
			{
				'min' -> i. 
				'max' -> (i+delta).
				'number' -> number
			} asDictionary
		]
	]