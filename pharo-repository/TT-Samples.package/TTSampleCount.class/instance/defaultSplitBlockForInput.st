defaults
defaultSplitBlockForInput
	^ [ :number :tasksNumber |
		self from: 1 to: number splitInto: tasksNumber collect: [ :min :max |
			{ 
				'min' -> min.
				'max' -> max
			} asDictionary.
		]
	]