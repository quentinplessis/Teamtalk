actions
input: input tasksNumber: tasksNumber callbackDo: callbackBlock
	| tasks resultsQueue splitInputs |
	
	tasks := OrderedCollection new.
	resultsQueue := SharedQueue new.
	splitInputs := (self splitBlockForInput value: input value: tasksNumber).
	splitInputs do: [ :subInput |
		| task |
		task := TTTask
			executionCode: self mapBlockForSubInput
			resultProcessCode: (self processResultsIn: resultsQueue callbackBlock: callbackBlock tasksNumber: (splitInputs size))
			input: subInput.
		tasks add: task
	].

	self ttClient addTasks: tasks