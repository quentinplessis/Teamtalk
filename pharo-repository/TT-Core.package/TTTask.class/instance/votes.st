accessing
votes
	^ votes ifNil: [ votes := OrderedCollection new ]