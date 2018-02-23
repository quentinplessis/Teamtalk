accessing
allTasks
	^ allTasks ifNil: [ allTasks := Dictionary new ]