helpers
from: from to: to splitInto: number collect: block
	| delta |
	
	delta := ((to-from) / number) ceiling.
	delta = 0 ifTrue: [ delta := 1 ].
	
	^ (from to: (to-1) by: delta) collect: [ :i |
		block value: i value: ((i+delta-1) min: to)
	]