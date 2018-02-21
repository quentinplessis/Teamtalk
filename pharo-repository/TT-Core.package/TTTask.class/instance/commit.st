actions
commit
	self resetVotes.
	self resetHighestVoter.
	self commitTime: (DateAndTime now).
	self status: (TTTaskStatus commited).
	