# Teamtalk

Simple library to execute Pharo Smalltalk code in a cluster of Pharo Smalltalk instances.
MapReduce is also supported.

Based on [Vert.x](http://vertx.io/) using the [VerStix](https://github.com/mumez/VerStix) library.

## Installation

## Get Started
Setup Vert.x verticle.

```
$ docker run -p 8080:8080 plequen/teamtalk-server
```

*[Image A]* Create a producer

```smalltalk
producer := TTProducer host: 'localhost' port: 8080.
```

*[Image B]* Create a worker

```smalltalk
worker := TTWorker host: 'localhost' port: 8080.
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


