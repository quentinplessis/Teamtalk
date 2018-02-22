accessing
currentlyAttributedTasks
	^ currentlyAttributedTasks ifNil: [ currentlyAttributedTasks := SharedQueue new ]