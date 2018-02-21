initialize-release
initialize
	self uuid: (UUID new asString).
	self status: (TTTaskStatus created).