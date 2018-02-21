defaults
defaultSplitBlockForInput
	^ [ :number :tasksNumber |
		| delta |
	
		delta := ((number + 1) / tasksNumber) ceiling.
		delta = 0 ifTrue: [ delta := 1 ].
	
		(1 to: number by: delta) collect: [ :i |
			{ 
				'min' -> i.
				'max' -> ((i+delta-1) min: number)
			} asDictionary.
		]
	]