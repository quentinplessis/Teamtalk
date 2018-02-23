private-tasks-producer
receivedSlotSupplyMessage: msg
	| taskAllocationSlot |
	taskAllocationSlot := TTTaskAllocationSlot from: msg body.
	taskAllocationSlot producerCode = self uuid ifFalse: [ ^ nil ].
	self receivedSuppliedSlotsQueue nextPut: taskAllocationSlot.
	self log: ('Received supplied slot {1}' format: { taskAllocationSlot description })