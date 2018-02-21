accessing
shouldLoopManageTasks
	^ shouldLoopManageTasks ifNil: [ shouldLoopManageTasks := false ]