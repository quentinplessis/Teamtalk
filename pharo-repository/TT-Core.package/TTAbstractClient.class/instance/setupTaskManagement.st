private-processes
setupTaskManagement
	self isWorker ifTrue: [
		self eventBus subscribe: (self defaultSlotDemandAddress) callback: [ :msg | self receivedSlotDemandMessage: msg ].
		self eventBus subscribe: (self defaultTaskAttributionAddress) callback: [ :msg | self receivedTaskAttributionMessage: msg ].
		self startConsumerTaskManagementProcess.
	].
	self isProducer ifTrue: [
		self eventBus subscribe: (self defaultSlotSupplyAddress) callback: [ :msg | self receivedSlotSupplyMessage: msg ].
		self eventBus subscribe: (self defaultExecutedTasksAddress) callback: [ :msg | self receivedExecutedTaskMessage: msg ].
		self startProducerTaskManagementProcess.
	].