#!/bin/bash

set -e

NODENAME=${NODENAME:-"bondy"}
HOSTNAME=`hostname -f`
BONDY_HOME="/bondy"
CONFIG_FILE="$BONDY_HOME/etc/bondy.conf"

# Rename erlang node longname
echo "Renaming nodename to $NODENAME@$HOSTNAME"
sed -i "s/^nodename = bondy@127.0.0.1/nodename = $NODENAME@$HOSTNAME/" $CONFIG_FILE

exec bondy foreground
