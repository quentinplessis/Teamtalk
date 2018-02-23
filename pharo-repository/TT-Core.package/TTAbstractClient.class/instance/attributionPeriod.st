accessing
attributionPeriod
	^ attributionPeriod ifNil: [ attributionPeriod := self defaultAttributionPeriod ]