# bondy_docker

## What is Bondy?

Bondy is an open source, distributed, scaleable and robust networking platform for microservices and IoT applications written in Erlang.

It implements the open Web Application Messaging Protocol (WAMP) offering both Publish and Subscribe (PubSub) and routed Remote Procedure Calls (RPC) comunication patterns. It also provides a built-in HTTP/REST API Gateway.

Bondy is Apache2 licensed.

Read more about Bondy at http://docs.getbondy.io.

This repository is used to automatically build the official Bondy Docker images published at Docker Hub and for local development.

## How to run an image locally?

You can run an official Bondy Docker image using the `docker run` command with an image name using the following syntax:   `leapsight/bondy:{VERSION}[-{VARIANT}]`.

Where `{VERSION}` can be `master`, `develop` or a tag like `0.8.6` and `{VARIANT}` is null or `slim` (we will provide the `alpine` variant in the future).

For example to run the 0.8.6 release you would use:

```bash
docker run -d leapsight/bondy:0.8.6
```

To run the slim variant of the same release you would use:

```bash
docker run -d leapsight/bondy:0.8.6-slim
```

### Exposing ports

The docker image exposes the following ports:

|PORT|DESCRIPTION|
|---|---|
|18080|API GATEWAY HTTP and WAMP WS|
|18081|ADMIN API HTTP|
|18082|WAMP RAW SOCKET TCP|
|18083|API GATEWAY HTTPS and WSS|
|18084|ADMIN API HTTPS|
|18085|WAMP RAW SOCKET TLS|
|18086|CLUSTER PEER SERVICE|


In case you need to expose them or want to configure port mapping you would run it like this:

```bash
docker run \
    -p 18080:18080 \
    -p 18081:18081 \
    -p 18082:18082 \
    -p 18086:18086 \
    --name bondy1 \
    -d leapsight/bondy:0.8.6
```

To learn more about the different variants go to https://hub.docker.com/r/leapsight/bondy/.

## Customising Bondy configuration files

```bash
docker run \
    -p 18080:18080 \
    -p 18081:18081 \
    -p 18082:18082 \
    -p 18086:18086 \
    --name bondy1 \
    -v ~/tmp/bondy/etc:/bondy/etc \
    -d leapsight/bondy:develop
```


## Additional tools for contributors

If you need to build an image locally you can use the following make targets with the provided Makefile.

```shell
make develop
```

```shell
make develop-slim
```

In case you need to change the bondy configuration files, you can follow the examples in the examples folder.

There is even a target for that.

```
make example-custom-config
```

Once you build your iamge you would run it like this:

```bash
docker run \
    -p 18080:18080 \
    -p 18081:18081 \
    -p 18082:18082 \
    -p 18086:18086 \
    --name bondy-example-custom-config \
    -d example-custom-config
```