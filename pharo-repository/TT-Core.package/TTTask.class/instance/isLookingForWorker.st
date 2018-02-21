testing
isLookingForWorker
	^ self isCommited and: [ self status < TTTaskStatus attributed ]