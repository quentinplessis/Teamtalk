formatting
description
	^ '[TaskAllocationSlot] {1} (producer: {2}, tasks: {3}, expirationDate: {4}, worker: {5})' format: { self uuid. self producerCode. self tasks size. self expirationDate. self workerCode }