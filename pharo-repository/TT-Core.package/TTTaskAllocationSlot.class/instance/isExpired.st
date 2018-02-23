testing
isExpired
	^ (DateAndTime now) asUnixTime > self expirationDate