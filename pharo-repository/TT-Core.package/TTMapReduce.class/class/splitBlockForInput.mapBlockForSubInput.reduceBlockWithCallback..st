instance-creation
splitBlockForInput: splitBlockForInput mapBlockForSubInput: mapBlockForSubInput reduceBlockWithCallback: reduceBlockWithCallback
	^ self new
		splitBlockForInput: splitBlockForInput;
		mapBlockForSubInput: mapBlockForSubInput;
		reduceBlockWithCallback: reduceBlockWithCallback;
		yourself