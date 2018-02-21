private-tasks
receivedAttributedTaskMessage: msg
	self extractTaskMessage: msg body do: [ :producerCode :receivedTasks |
		| attributedTasks |
		attributedTasks := receivedTasks select: [ :task |
			(task at: 'highestVoter' ifAbsent: [ ]) = self uuid
		].
		Transcript logCr: ('Received attributed tasks {1}' format: { ', ' join: attributedTasks }).
		attributedTasks do: [ :task |
			| newTask |
			newTask := TTTask new.
			task keysAndValuesDo: [ :key :value |
				newTask at: key put: value.
			].
			newTask execute.
			Transcript logCr: ('Send finished task {1}' format: { newTask }).
			self eventBus publish: {
				'producerCode' -> producerCode.
				'workerCode' -> (self uuid).
				'tasks' -> { newTask }.
			} to: (self defaultFinishedTasksAddress)
		]. 
	].