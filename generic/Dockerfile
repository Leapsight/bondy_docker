<<<<<<< HEAD
# ===========================================================================
# Build stage 0
# ===========================================================================

FROM erlang:21 AS builder

ARG BONDY_REPO=https://gitlab.com/leapsight/bondy.git
ARG BONDY_TAG=0.8.5
ARG BONDY_REBAR_PROFILE=prod

WORKDIR /bondy-build

# Install build deps
RUN apt-get update && \
    apt-get -y install build-essential git libssl-dev curl

# Download and install build deps and rebar
RUN set -xe \
    && curl -fSL -o rebar3 "https://s3.amazonaws.com/rebar3-nightly/rebar3" \
    && chmod +x ./rebar3 \
    && ./rebar3 local install \
    && rm ./rebar3
ENV PATH "$PATH:/root/.cache/rebar3/bin"

# Download Bondy source and build release
RUN mkdir -p /bondy-build/bondy && \
    git clone --branch $BONDY_TAG  --single-branch --depth 1 $BONDY_REPO
WORKDIR /bondy-build/bondy
RUN rebar3 as $BONDY_REBAR_PROFILE release

# ===========================================================================
# Build stage 1
# ===========================================================================

FROM debian:stretch

ENV BONDY_HOME="/bondy"
ENV RELEASE_DIR="/bondy-build/bondy/_build/prod/rel/bondy"

=======
# Build stage 0
FROM erlang:21-slim AS builder

ARG BONDY_REPO=https://gitlab.com/leapsight/bondy.git
ARG BONDY_TAG=0.8.4
ARG BONDY_PROFILE=prod

WORKDIR /bondy-build

# Install Rebar3
RUN mkdir -p /bondy-build/rebar3/bin
ADD https://s3.amazonaws.com/rebar3/rebar3 /bondy-build/rebar3/bin/rebar3
RUN chmod a+x /bondy-build/rebar3/bin/rebar3
ENV PATH=/bondy-build/rebar3/bin:$PATH


# Install build deps and download bondy source

RUN apt-get update && \
    apt-get -y install build-essential git libssl-dev && \
    git clone --branch $BONDY_TAG  --single-branch --depth 1 $BONDY_REPO

# Build Bondy release
RUN mkdir -p /bondy-build/bondy
WORKDIR /bondy-build/bondy
RUN rebar3 as $BONDY_PROFILE release

# ===========================================================================

FROM debian:stretch-slim


ENV BONDY_HOME="/bondy"
ARG BONDY_CONFIG="$BONDY_HOME/etc/bondy.conf"
ENV USERNAME=bondy
ENV GROUPNAME=$USERNAME
ENV RELEASE_DIR="/bondy-build/bondy/_build/prod/rel/bondy"
ENV PATH="$BONDY_HOME/bin:$PATH"
>>>>>>> reorg generic and added example
ENV BONDY_LOG_CONSOLE=console
ENV BONDY_LOG_LEVEL=info
ENV RELX_REPLACE_OS_VARS=true
ENV ERL_CRASH_DUMP=/dev/null
ENV KUBERNETES_LABEL_SELECTOR="app=bondy"

<<<<<<< HEAD
RUN apt-get update \
    && apt-get -y install openssl iproute2 curl jq \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 1000 -r bondy \
    && useradd -u 1000 -r -g bondy -d $BONDY_HOME -s /bin/bash -c "Bondy user" bondy

WORKDIR $BONDY_HOME


# Install the application and the start.sh script
# COPY --chown=1000:1000 files/vm.args /bondy/etc/vm.args
COPY --chown=bondy:bondy --from=builder $RELEASE_DIR $BONDY_HOME
COPY --chown=bondy:bondy start.sh $BONDY_HOME/bin/start_bondy
ENV PATH="$BONDY_HOME/bin:$PATH"
=======
RUN apt-get update && \
    apt-get -y install openssl iproute2 curl jq && \
    rm -rf /var/lib/apt/lists/* && \
    addgroup --gid 10000 $GROUPNAME && \
    adduser --uid 10000 --ingroup $GROUPNAME --home $BONDY_HOME --disabled-password $USERNAME
    # install --directory --owner $USERNAME --group $GROUPNAME $BONDY_HOME

WORKDIR $BONDY_HOME

# Install the released application
# COPY --chown=10000:10000 files/vm.args /bondy/etc/vm.args
COPY --chown=10000:10000 --from=builder $RELEASE_DIR $BONDY_HOME

RUN echo "Configuring nodename" && \
    sed "s/^nodename = bondy@127.0.0.1/nodename = bondy@$(hostname -f)/" $BONDY_CONFIG
>>>>>>> reorg generic and added example

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
<<<<<<< HEAD

USER bondy
VOLUME ["/bondy/data", "/bondy/etc", "/bondy/tmp", "/bondy/log"]
WORKDIR $BONDY_HOME
CMD ["start_bondy"]
=======
VOLUME ["/bondy/data"]
USER $USERNAME
CMD ["bondy", "foreground"]
>>>>>>> reorg generic and added example
