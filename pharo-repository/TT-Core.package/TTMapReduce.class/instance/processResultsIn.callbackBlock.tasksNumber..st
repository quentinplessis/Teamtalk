private
processResultsIn: resultsQueue callbackBlock: callbackBlock tasksNumber: tasksNumber
	^ [ :result |
		resultsQueue nextPut: result.
		resultsQueue size = tasksNumber ifTrue: [ 
			| results |
			results := OrderedCollection new.
			[ resultsQueue isEmpty ] whileFalse: [
				results add: (resultsQueue next)
			].
			self reduceBlockWithCallback value: results value: callbackBlock
		]
	]