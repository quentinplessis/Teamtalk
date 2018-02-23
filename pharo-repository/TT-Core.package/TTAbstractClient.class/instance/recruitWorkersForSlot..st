private-tasks-producer
recruitWorkersForSlot: taskAllocationSlot
	taskAllocationSlot expirationDate: (DateAndTime now + self attributionPeriod) asUnixTime.
	self eventBus publish: taskAllocationSlot to: (self defaultSlotDemandAddress).
	self log: ('Committed slot {1}' format: { taskAllocationSlot description })