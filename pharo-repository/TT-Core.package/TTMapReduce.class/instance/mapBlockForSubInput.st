accessing
mapBlockForSubInput
	^ mapBlockForSubInput ifNil: [ mapBlockForSubInput := self defaultMapBlockForSubInput ]