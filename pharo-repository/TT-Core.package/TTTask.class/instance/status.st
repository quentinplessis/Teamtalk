accessing
status
	^ self at: #status ifAbsent: [ TTTaskStatus unknown ]