# Teamtalk

Simple library to execute Smalltalk code in a cluster of Pharo Smalltalk instances.
MapReduce is also supported.

## Installation

## Get Started
Setup Vert.x verticle.

```
$ vertx run TcpEventBusBridgeEchoServer.groovy
```

*[Image A]* Create a producer

```smalltalk
producer := TTProducer host: 'localhost' port: 7000.
```

*[Image B]* Create a worker

```smalltalk
worker := TTWorker host: 'localhost' port: 7000.
```

*[Image A]* Add a task to execute

```smalltalk
task := TTTask	executionCode: [
		"Image B
		'Do some work' inspect.
		2 + 2	]	resultProcessCode: [ :result |
		"Image A"		result inspect. "4"	].producer addTask: task.
```


## Examples


