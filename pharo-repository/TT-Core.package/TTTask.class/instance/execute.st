actions
execute
	| executionCode |
	executionCode := Smalltalk compiler evaluate: self executionCodeString.
	self input
		ifNil: [ self result: executionCode value. ]
		ifNotNil: [ self result: (executionCode value: self input). ].
	^ self result