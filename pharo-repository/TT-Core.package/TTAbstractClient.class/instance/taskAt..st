accessing
taskAt: taskUUID
	^ self tasks at: taskUUID ifAbsent: [ ]