private-tasks-producer
gatherRecruitedWorkers
	| slotsToAttribute |
	slotsToAttribute := Dictionary new.
	[ self receivedSuppliedSlotsQueue isEmpty ] whileFalse: [ 
		| slotToAttribute recruitedWorkers |
		slotToAttribute := self receivedSuppliedSlotsQueue next.
		recruitedWorkers := slotsToAttribute at: (slotToAttribute uuid) ifAbsentPut: [ { slotToAttribute. Set new } ].
		recruitedWorkers second add: slotToAttribute workerCode.
	].
	^ slotsToAttribute