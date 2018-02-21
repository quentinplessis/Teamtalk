accessing
splitBlockForInput
	^ splitBlockForInput ifNil: [ splitBlockForInput := self defaultSplitBlockForInput ]