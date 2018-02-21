accessing
highestVoter
	| voter |
	voter := self at: #highestVoter ifAbsent: [ ].
	voter ifNil: [ self at: #highestVoter put: self determineHighestVoter ].
	^ self at: #highestVoter