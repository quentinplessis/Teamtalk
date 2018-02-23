initialize-release
shutdown
	[
		self releaseProcesses.
		self eventBus release.
		self resetTasksQueue.
		self resetReceivedDemandedSlotsQueue.
		self resetReceivedSuppliedSlotsQueue.
		self resetTasksToExecute.
	] forkAt: Processor userBackgroundPriority 