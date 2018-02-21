testing
hasWorkerAttributionPeriodExpiredLimit: limit
	self commitTime ifNil: [ ^ false ].
	^ (DateAndTime now asUnixTime - self commitTime asUnixTime) > limit seconds