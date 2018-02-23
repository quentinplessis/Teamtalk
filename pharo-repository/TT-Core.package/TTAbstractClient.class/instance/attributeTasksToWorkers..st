private-tasks-producer
attributeTasksToWorkers: recruitedWorkers
	| attributedTasks usedWorkers |
	usedWorkers := Set new.
	attributedTasks := OrderedCollection new.
	(recruitedWorkers keys sorted: [ :a :b | (recruitedWorkers at: a) second size < (recruitedWorkers at: b) second size ]) do: [ :slotUUID |
		| slotToAttribute worker |
		slotToAttribute := (recruitedWorkers at: slotUUID).
		slotToAttribute first tasks do: [ :taskDictionary |
			worker := slotToAttribute second asArray shuffle detect: [ :workerCode | (usedWorkers includes: workerCode) not ] ifNone: [ ].
			worker ifNotNil: [
				| taskToAttribute |
				taskToAttribute := TTTask from: taskDictionary.
				self attributeTask: taskToAttribute to: worker.
				attributedTasks add: taskToAttribute.
				usedWorkers add: worker.
			]
		].
	].
	^ attributedTasks
	