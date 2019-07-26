#!/bin/bash

set -e

echo "Replacing os environment variables in bondy.conf"
cp /bondy/etc/bondy.conf /tmp/user.conf
/bondy/etc/replace-env-vars -i /tmp/user.conf -o /tmp/bondy.conf
namei -l /bondy/etc/bondy.conf
whoami
cp /tmp/bondy.conf /bondy/etc/bondy.conf
exec bondy foreground

