accessing
receivedDemandedSlotsQueue
	^ receivedDemandedSlotsQueue ifNil: [ receivedDemandedSlotsQueue := SharedQueue new ]