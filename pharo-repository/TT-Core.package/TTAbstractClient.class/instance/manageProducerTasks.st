private-tasks
manageProducerTasks
	| tasksToCommit tasksToAttribute |
	tasksToCommit := OrderedCollection new.
	tasksToAttribute := OrderedCollection new.
	self tasks keysAndValuesDo: [ :taskUUID :task |
		task isCommited ifTrue: [ 
			task isAttributed ifFalse: [
				(task hasWorkerAttributionPeriodExpiredLimit: self defaultAttributionPeriodLimit) ifTrue: [
					task hasHighestWorker
						ifTrue: [ tasksToAttribute add: task ]
						ifFalse: [ tasksToCommit add: task. ].
				]
			]
		] ifFalse: [ tasksToCommit add: task. ]
	].
	self commitTasks: tasksToCommit.
	self attributeTasks: tasksToAttribute.