private
determineHighestVoter
	| maxScore highestVoter |
	
	maxScore := 0.
	highestVoter := nil.

	self votes do: [ :vote |
		| score |
		score := (vote at: 'vote').
		(score > maxScore) ifTrue: [ 
			highestVoter := (vote at: 'workerCode').
			maxScore := score.
		].
	].

	^ highestVoter