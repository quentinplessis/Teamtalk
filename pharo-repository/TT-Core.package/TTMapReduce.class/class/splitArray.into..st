helpers
splitArray: array into: number
	^ self from: 1 to: array size splitInto: number collect: [ :min :max |
		array copyFrom: min to: max
	]