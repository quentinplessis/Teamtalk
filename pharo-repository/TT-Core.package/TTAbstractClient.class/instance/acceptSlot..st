private-tasks-consumer
acceptSlot: taskAllocationSlot
	taskAllocationSlot workerCode: self uuid.
	self eventBus publish: taskAllocationSlot to: (self defaultSlotSupplyAddress).
	self log: ('Accepted slot {1}' format: { taskAllocationSlot description })