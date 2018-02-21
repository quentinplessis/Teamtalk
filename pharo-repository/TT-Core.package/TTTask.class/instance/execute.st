actions
execute
	self input ifNil: [
		self result: (self executionCode value).
		^ self result
	].
	self result: (self executionCode value: self input).
	^ self result