private-tasks-producer
attributeTask: taskToAttribute to: worker
	taskToAttribute workerCode: worker.
	taskToAttribute producerCode: self uuid.
	self eventBus publish: taskToAttribute to: (self defaultTaskAttributionAddress).
	self log: ('Attribute task {1}' format: { taskToAttribute description })