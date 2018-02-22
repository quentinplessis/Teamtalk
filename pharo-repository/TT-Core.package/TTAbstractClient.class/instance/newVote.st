private-tasks
newVote
	self currentlyAttributedTasks size >= self defaultLimitAttributedTasks ifTrue: [ ^ 0 ].
	^ ((Random new next) / (1 + self consideredTasks size)) asFloat