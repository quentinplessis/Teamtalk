private-tasks-consumer
manageConsumerTasks
	| taskAllocationSlot |
	
	"Accept next non-expired slot"
	taskAllocationSlot := self receivedDemandedSlotsQueue next.
	taskAllocationSlot isExpired ifTrue: [ ^ nil ].
	self acceptSlot: taskAllocationSlot.
	2 timesRepeat: [ self attributionPeriod wait. ].
	
	"Execute tasks"
	[ self tasksToExecute isEmpty ] whileFalse: [ 
		| taskToExecute |
		taskToExecute := self tasksToExecute next.
		taskToExecute execute.
		self sendBackTaskResult: taskToExecute.
	].