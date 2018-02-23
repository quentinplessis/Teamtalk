formatting
description
	^ '[Task] {1} (producer: {2}, worker: {3}, input: {4}, result: {5})' format: { self uuid. self producerCode. self workerCode. self input. self result. }