private
processResultsCallbackBlock: callbackBlock tasksNumber: tasksNumber
	^ [ :result |
		self resultsQueue nextPut: result.
		self resultsQueue size = tasksNumber ifTrue: [ 
			| results |
			results := OrderedCollection new.
			[ self resultsQueue isEmpty ] whileFalse: [
				results add: (self resultsQueue next)
			].
			self reduceBlockWithCallback value: results value: callbackBlock
		]
	]