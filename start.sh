#!/bin/bash

set -e

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
    /bondy/bin/replace-env-vars -i "/tmp/$template" -o "/tmp/$file"
    # Copy to destination
    cp "/tmp/$file" "/bondy/etc/$file"
done

export RUNNER_ETC_DIR=/bondy/etc
export RUNNER_GEN_DIR=/bondy/tmp
export RUNNER_LOG_DIR=/bondy/log

exec bondy foreground

