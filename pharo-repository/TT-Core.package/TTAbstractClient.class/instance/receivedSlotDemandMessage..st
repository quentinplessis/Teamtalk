private-tasks-consumer
receivedSlotDemandMessage: msg
	| taskAllocationSlot |
	taskAllocationSlot := TTTaskAllocationSlot from: msg body.
	self receivedDemandedSlotsQueue nextPut: taskAllocationSlot.
	self log: ('Received demanded slot {1}' format: { taskAllocationSlot description })