accessing
ttClientClass
	^ ttClientClass ifNil: [ ttClientClass := self defaultTTClientClass ]