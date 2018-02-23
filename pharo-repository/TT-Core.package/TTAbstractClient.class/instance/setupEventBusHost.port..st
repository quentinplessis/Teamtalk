private-vertx
setupEventBusHost: host port: port.
	self eventBus ifNotNil: [ self eventBus release ].
	eventBus := (self createEventBus: host port: port).
	self eventBus connect.
	