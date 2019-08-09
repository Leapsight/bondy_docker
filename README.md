# bondy_docker

## What is Bondy?

Bondy is an open source, distributed, scaleable and robust networking platform for microservices and IoT applications written in Erlang.

It implements the open Web Application Messaging Protocol (WAMP) offering both Publish and Subscribe (PubSub) and routed Remote Procedure Calls (RPC) comunication patterns. It also provides a built-in HTTP/REST API Gateway.

Bondy is Apache2 licensed.

Read more about Bondy at http://docs.getbondy.io.

This repository is used to automatically build the officinal Bondy Docker images published at Docker Hub and for local development.

## How to use the official Bondy Docker images?

Go to https://hub.docker.com/r/leapsight/bondy/.


## Port Configuration

The docker image exposes the following ports

|PORT|DESCRIPTION|
|---|---|
|18080|API GATEWAY HTTP and WS|
|18081|ADMIN API HTTP|
|18082|WAMP RAW SOCKET TCP|
|18083|API GATEWAY HTTPS and WSS|
|18084|ADMIN API HTTPS|
|18085|WAMP RAW SOCKET TLS|
|18086|CLUSTER PEER SERVICE|

## How to run an image locally?

You can then run the Bondy image:

```bash
docker run \
    -p 18080:18080 \
    -p 18081:18081 \
    -p 18082:18082 \
    -p 18086:18086 \
    --name bondy1 \
    -d leapsight/bondy
```

## How to build an image locally?


```shell
make develop-slim
```


