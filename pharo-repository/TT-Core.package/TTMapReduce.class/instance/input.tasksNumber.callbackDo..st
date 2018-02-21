actions
input: input tasksNumber: tasksNumber callbackDo: callbackBlock
	| tasks |
	
	tasks := OrderedCollection new.
	(self splitBlockForInput value: input value: tasksNumber) do: [ :subInput |
		| task |
		task := TTTask
			executionCode: (self mapBlockForSubInput value: subInput)
			resultProcessCode: (self processResultsCallbackBlock: callbackBlock tasksNumber: tasksNumber).
		tasks add: task
	].

	self ttClient addTasks: tasks