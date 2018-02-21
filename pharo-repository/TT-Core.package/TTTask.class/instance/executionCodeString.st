accessing
executionCodeString
	^ self at: #executionCodeString ifAbsentPut: [ self defaultExecutionCode asString ]