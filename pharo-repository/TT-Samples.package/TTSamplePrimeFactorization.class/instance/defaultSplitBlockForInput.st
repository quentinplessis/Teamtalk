defaults
defaultSplitBlockForInput
	^ [ :number :tasksNumber |
		self from: 2 to: (number sqrt floor) splitInto: tasksNumber collect: [ :min :max |
			{
				'min' -> min. 
				'max' -> max.
				'number' -> number
			} asDictionary
		]
	]