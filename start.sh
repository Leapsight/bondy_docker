#!/bin/bash

set -e

NODENAME=${NODENAME:-"bondy"}
HOSTNAME=`hostname -f`
BONDY_HOME="/bondy"
CONFIG_FILE="$BONDY_HOME/etc/bondy.conf"
RUNNER="$BONDY_HOME/bin/bondy"

# Rename erlang node longname
echo "Using nodename $NODENAME@$HOSTNAME"
sed -i "s/^nodename = bondy@127.0.0.1/nodename = $NODENAME@$HOSTNAME/" $CONFIG_FILE

exec "$RUNNER" foreground
