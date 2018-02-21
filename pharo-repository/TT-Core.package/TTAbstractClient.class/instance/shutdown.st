initialize-release
shutdown
	[
		self releaseProcesses.
		self eventBus unsubscribe: 'tasks2'.
		self eventBus release.
		self resetTasks.
	] forkAt: Processor userBackgroundPriority 