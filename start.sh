#!/bin/bash

set -e

echo "Replacing os environment variables in bondy.conf"
cp /bondy/etc/bondy.conf.template /tmp/bondy.conf.template
/bondy/etc/replace-env-vars -i /tmp/bondy.conf.template -o /tmp/bondy.conf
cp /tmp/bondy.conf /bondy/etc/bondy.conf
exec bondy foreground

