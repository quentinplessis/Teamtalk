initialize-release
initialize
	super initialize.
	uuid := (UUID new asString).
	self logCr: ('Client {1} ({2})' format: { self uuid. self clientType }).