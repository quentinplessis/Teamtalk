accessing
resultProcessCode
	^ resultProcessCode ifNil: [ resultProcessCode := self defaultResultProcessCode ]