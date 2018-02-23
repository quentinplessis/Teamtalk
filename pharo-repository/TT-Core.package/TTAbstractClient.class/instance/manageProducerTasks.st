private-tasks-producer
manageProducerTasks
	| taskAllocationSlot attributedTasks recruitedWorkers tasksForSlot |
	
	"Gather recruited workers for each slot"
	recruitedWorkers := self gatherRecruitedWorkers.
	"Attribute a task to each worker"
	attributedTasks := self attributeTasksToWorkers: recruitedWorkers.
	self tasksQueue flushAllSuchThat: [ :task | attributedTasks includes: task uuid ].

	"Recruit new workers for the next taks"
	self tasksQueue isEmpty ifTrue: [ self tasksManagementInterval wait. ^ nil ].
	tasksForSlot := OrderedCollection new.
	self tasksQueue size timesRepeat: [
		tasksForSlot add: (self tasksQueue next).
	].
	taskAllocationSlot := TTTaskAllocationSlot producerCode: self uuid tasks: tasksForSlot.
	self recruitWorkersForSlot: taskAllocationSlot.
	self attributionPeriod wait.
	