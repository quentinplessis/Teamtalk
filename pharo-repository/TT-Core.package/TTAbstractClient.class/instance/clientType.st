formatting
clientType
	(self isProducer and: [ self isWorker ]) ifTrue: [ ^ 'WorkerProducer' ].
	self isProducer ifTrue: [ ^ 'Producer' ].
	self isWorker ifTrue: [ ^ 'Worker' ].
	^ 'Unknown'