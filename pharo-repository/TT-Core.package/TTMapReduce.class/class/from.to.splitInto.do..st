helpers
from: from to: to splitInto: number do: block
	| delta |
	
	delta := ((to-from) / number) ceiling.
	delta = 0 ifTrue: [ delta := 1 ].
	
	^ (from to: (to-1) by: delta) do: [ :i |
		block value: i value: ((i+delta-1) min: to)
	]