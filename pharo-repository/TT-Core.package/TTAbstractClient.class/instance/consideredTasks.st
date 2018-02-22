accessing
consideredTasks
	^ consideredTasks ifNil: [ consideredTasks := SharedQueue new ]