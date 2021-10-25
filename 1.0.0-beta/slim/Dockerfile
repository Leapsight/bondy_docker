# ===========================================================================
# Build stage 0
# ===========================================================================

FROM erlang:24-slim AS builder

ARG BONDY_TAG

ENV BONDY_REPO=https://gitlab.com/leapsight/bondy.git

WORKDIR /bondy-build

# Install build deps
RUN apt-get update && \
    apt-get -y install build-essential git libssl-dev libsodium-dev libsnappy-dev curl

# Download and install build deps and rebar
RUN set -xe \
    && curl -fSL -o rebar3 "https://s3.amazonaws.com/rebar3/rebar3" \
    && chmod +x ./rebar3 \
    && ./rebar3 local install \
    && rm ./rebar3
ENV PATH "$PATH:/root/.cache/rebar3/bin"

# Download Bondy source and build release
RUN mkdir -p /bondy-build/bondy && \
    git clone --branch $BONDY_TAG  --single-branch --depth 1 $BONDY_REPO
WORKDIR /bondy-build/bondy
# This builds the release in /bondy-build/bondy/_build/prod/rel/bondy
RUN rebar3 as prod release

# ===========================================================================
# Build stage 1
# ===========================================================================

FROM debian:buster

ENV BONDY_HOME="/bondy"
ENV RELEASE_DIR="/bondy-build/bondy/_build/prod/rel/bondy"

ENV BONDY_LOG_CONSOLE=console
ENV BONDY_LOG_LEVEL=info
ENV RELX_REPLACE_OS_VARS=true
ENV ERL_CRASH_DUMP=/dev/null
ENV KUBERNETES_LABEL_SELECTOR="app=bondy"

RUN apt-get update \
    && apt-get -y install bash openssl libsodium-dev iproute2 procps libsnappy-dev curl jq \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 1000 -r bondy \
    && useradd -u 1000 -r -g bondy -d $BONDY_HOME -s /bin/bash -c "Bondy user" bondy

RUN mkdir $BONDY_HOME && chown bondy:bondy $BONDY_HOME
USER bondy:bondy
WORKDIR $BONDY_HOME

COPY --chown=bondy:bondy --from=builder $RELEASE_DIR $BONDY_HOME
ENV PATH="$BONDY_HOME/bin:$PATH"

# Ports
# 4369  EPMD - Erlang Port Mapper Daemon
# 18080 API GATEWAY HTTP and WS
# 18081 ADMIN API HTTP
# 18082 WAMP TCP
# 18083 API GATEWAY HTTPS and WSS
# 18084 ADMIN API HTTPS
# 18085 WAMP TLS
# 18086 CLUSTER PEER SERVICE
EXPOSE 18080 18081 18082 18083 18084 18085 18086


# set home so that any `--user` knows where to put the erlang cookie
ENV HOME "/bondy"
VOLUME ["/bondy/data", "/bondy/etc", "/bondy/tmp", "/bondy/log"]
WORKDIR $BONDY_HOME
ENTRYPOINT ["bondy", "foreground"]
