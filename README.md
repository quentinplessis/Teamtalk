# Teamtalk

Simple library to execute Pharo Smalltalk code in a cluster of Pharo Smalltalk instances.
MapReduce is also supported.

Based on [Vert.x](http://vertx.io/) using the [VerStix](https://github.com/mumez/VerStix) library.

## Installation

```smalltalk
Metacello new
    baseline: 'Teamtalk';
    repository: 'github://quentinplessis/Teamtalk/pharo-repository';
    load.
```

## Get Started

### Manual setup

Setup Teamtalk server (Vert.x verticle).

```
$ docker run -p 8080:8080 plequen/teamtalk-server
```

*[Pharo Image A]* Create a producer

```smalltalk
producer := TTProducer host: 'localhost' port: 8080.
```

*[Pharo Image B]* Create a worker

```smalltalk
worker := TTWorker host: 'localhost' port: 8080.
```

*[Pharo Image A]* Add a task to execute

```smalltalk
task := TTTask
	executionCode: [
		"Image B"
		'Do some work' inspect.
		2 + 2
	]
	resultProcessCode: [ :result |
		"Image A"
		result inspect. "4"
	].
producer addTask: task.
```

### Cluster setup

- Install Teamtalk in a Pharo image Teamtalk.image.

- Setup a teamtalk server on port 8080

```
export TEAMTALK_SERVER_PORT=8080
ruby spawner.rb --create-server $TEAMTALK_SERVER_PORT
```
- Retrieve server IP: 

```
ifconfig | grep inet
export TEAMTALK_SERVER_IP=.....
```

- Add consumers (Pharo 6.1)

```
ruby spawner.rb --create-consumer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
ruby spawner.rb --create-consumer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
ruby spawner.rb --create-consumer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
```

- Add a producer (Pharo 6.1)

```
ruby spawner.rb --create-producer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
```
- Connect to the producer via VNC (port 6001, password: vncpassword) and setup the producer

```smalltalk
producer := TTProducer host: 'IP' port: 8080.
```

- List all cluster nodes (current machine only)

```
ruby spawner.rb --list-all
```

- Remove all cluster nodes (current machine only)

```
ruby spawner.rb --remove-all
```

## Examples

### Simple tasks without callback

```smalltalk
producer := TTProducer host: 'localhost' port: 8080.producer addTask: (TTTask executionCode: [ 1 inspect. 5 seconds wait. nil ]).producer addTask: (TTTask executionCode: [ 2 inspect. 5 seconds wait. nil ]).producer addTask: (TTTask executionCode: [ 3 inspect. 5 seconds wait. nil ]).
producer addTask: (TTTask executionCode: [ 4 inspect. 5 seconds wait. nil ]).

"To remove producer from cluster"
producer shutdown.
```

### Measure completion time of several tasks

```smalltalk
producer := TTProducer host: 'localhost' port: 8080.

[	start := DateAndTime now.	number := 4.	i := 0.	number timesRepeat: [  		task := TTTask			executionCode: [			  	10 seconds wait.				'OK' inspect.				'OK'	  		]	  		resultProcessCode: [ :result |				i := i + 1.				i = number ifTrue: [ 					(DateAndTime now asUnixTime - start asUnixTime) inspect				].	  		].  		producer addTask: task.	].] fork.

"To remove producer from cluster"
producer shutdown.
```

Sample results:

- 1 worker: 43 seconds
- 2 workers: 23 seconds
- 4 workers: 13 seconds

## MapReduce

### Usage

```smalltalk
mapReduce := (TTMapReduce	splitBlockForInput: [ :input :tasksNumber | 		"split input into sub inputs here"	]	mapBlockForSubInput: [ :subInput | 		"process sub inputs here"
		"map sub input to sub result"	]	reduceBlockWithCallback: [ :results :callback |		"reduce sub results here"		callback value: results	])	ttClientClass: TTProducer;
	host: 'localhost'	port: 8080;	yourself.mapReduce	input: { }	tasksNumber: 4	callbackDo: [ :result | result inspect ].

"To remove from cluster"
mapReduce ttClient shutdown.
```

### Example: search in a dataset

```smalltalk
mapReduce := (TTMapReduce	splitBlockForInput: [ :input :tasksNumber | 		(TTMapReduce splitArray: (input at: 'dataset') into: tasksNumber) collect: [ :subDataset |			{				'searched' -> (input at: 'searched').				'dataset' -> subDataset.			} asDictionary		].	]	mapBlockForSubInput: [ :input | 		| dataset searched |		dataset := input at: 'dataset'.		searched := input at: 'searched'.		dataset includes: searched	]	reduceBlockWithCallback: [ :results :callback |		callback value: (results includes: true)	])	ttClientClass: TTProducer;
	host: 'localhost';	port: 8080;	yourself.dataset := { 'Ruby'. 'Python'. 'Java'. 'Smalltalk'. 'C'. 'Go' }.

"Search the word 'SmallTalk' in the dataset"mapReduce	input: {		'searched' -> 'SmallTalk'.		'dataset' -> dataset	} asDictionary	tasksNumber: 3	callbackDo: [ :result | result inspect ].

"Search the word 'Smalltalk' in the dataset"
mapReduce	input: {		'searched' -> 'Smalltalk'.		'dataset' -> dataset	} asDictionary	tasksNumber: 3	callbackDo: [ :result | result inspect ]."To remove from cluster"
mapReduce ttClient shutdown.```

### Sample: sum of numbers from 1 to x

```smalltalk
sampleCount := TTSampleCount new host: 'localhost'; port: 8080; yourself.sampleCount input: 100 tasksNumber: 4 callbackDo: [ :result | result inspect ].sampleCount input: 99 tasksNumber: 4 callbackDo: [ :result | result inspect ].sampleCount input: 10 tasksNumber: 4 callbackDo: [ :result | result inspect ].

"To remove from cluster"
sampleCount ttClient shutdown.
```

### Sample: Prime Factorization

```smalltalk
primeFactorization := TTSamplePrimeFactorization new host: 'localhost'; port: 8080; yourself.primeFactorization input: (1299821 * 1299827) tasksNumber: 2 callbackDo: [ :result | result inspect ].
primeFactorization input: (143) tasksNumber: 2 callbackDo: [ :result | result inspect ].

"To remove from cluster"
primeFactorization ttClient shutdown.
```
