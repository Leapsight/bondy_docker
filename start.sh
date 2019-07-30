#!/bin/bash

set -e

echo "Replacing os environment variables in bondy.conf"
cp /bondy/etc/bondy.conf.template /tmp/bondy.conf.template
/bondy/etc/replace-env-vars -i /tmp/bondy.conf.template -o /tmp/bondy.conf
cp /tmp/bondy.conf /bondy/etc/bondy.conf
export RUNNER_ETC_DIR=/bondy/etc
export RUNNER_GEN_DIR=$RUNNER_ETC_DIR
export RUNNER_LOG_DIR=/bondy/log
exec bondy foreground

