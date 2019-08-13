#!/bin/bash

set -e

# USER_CONF=/bondy/etc/bondy.conf.template
# if test -f "$USER_CONF"; then
#     echo "Replacing os environment variables in $USER_CONF"
#     cp /bondy/etc/bondy.conf.template /tmp/bondy.conf.template
#     /bondy/etc/replace-env-vars -i /tmp/bondy.conf.template -o /tmp/bondy.conf
#     cp /tmp/bondy.conf /bondy/etc/bondy.conf
# fi
shopt -s nullglob

for absolute in /bondy/etc/*.template; do
    # Drop the prefix path /bondy/etc
    template="${absolute##/bondy/etc/}"
    echo "Replacing os environment variables in /bondy/etc/$template"
    # Copy to a tmp location
    cp $absolute "/tmp/$template"
    # Drop the .template extension
    file="${template%.template}"
    # Perform variable replacement
    /bondy/etc/replace-env-vars -i "/tmp/$template" -o "/tmp/$file"
    # Copy to destination
    cp "/tmp/$file" "/bondy/etc/$file"
done

export RUNNER_ETC_DIR=/bondy/etc
export RUNNER_GEN_DIR=/bondy/tmp
export RUNNER_LOG_DIR=/bondy/log

exec bondy foreground

