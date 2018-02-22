private-tasks
newVote
	^ ((Random new next) / (1 + self consideredTasks size)) asFloat