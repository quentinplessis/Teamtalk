initialize-release
host: host port: port
	| eb |
	eb := self createEventBus: host port: port.
	self setupEventBus: eb.
	self uuid: (UUID new asString).
	self setupTaskManagement.