accessing
executionCode
	^ executionCode ifNil: [ executionCode := self compiledExecutionCodeString ]