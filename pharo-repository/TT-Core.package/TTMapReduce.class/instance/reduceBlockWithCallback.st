accessing
reduceBlockWithCallback
	^ reduceBlockWithCallback ifNil: [ reduceBlockWithCallback := self defaultReduceBlockWithCallback ]