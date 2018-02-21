private-tasks
setupTaskManagement
	self isWorker ifTrue: [
		self eventBus subscribe: (self defaultOpenTasksAddress) callback: [ :msg | self receivedOpenTaskMessage: msg ].
		self eventBus subscribe: (self defaultAttributedTasksAddress) callback: [ :msg | self receivedAttributedTaskMessage: msg ].
	].
	self isProducer ifTrue: [
		self eventBus subscribe: (self defaultVotesAddress) callback: [ :msg | self receivedVoteMessage: msg ].
		self eventBus subscribe: (self defaultFinishedTasksAddress) callback: [ :msg | self receivedFinishedTaskMessage: msg ].
	].
	self startTaskManagementProcess.