instance-creation
from: dictionary
	| instance |
	instance := self new.
	dictionary keysAndValuesDo: [ :key :value |
		instance at: key put: value.
	].
	^ instance
	