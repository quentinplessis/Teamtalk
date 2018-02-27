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

- Add consumers

```
ruby spawner.rb --create-consumer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
ruby spawner.rb --create-consumer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
ruby spawner.rb --create-consumer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
```

- Add a producer

```
ruby spawner.rb --create-producer --pharo-image ./Teamtalk.image --server-host $TEAMTALK_SERVER_IP --server-port $TEAMTALK_SERVER_PORT
```
- Connect to the producer via VNC (port 6001) and setup the producer

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


