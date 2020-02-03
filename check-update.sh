#!/bin/bash

HOST="$(hostname || tr -d '\n')"
IP="$(curl ifconfig.me)"
UPDATES="$(sudo yum check-update)"
NOTICE="$(sudo yum updateinfo summary updates)"
HOOK="<slack_webhook_url_here>"

sudo yum check-update
if [[ $? = 100 ]]; then
    curl -X POST -H 'Content-type: application/json' --data '{"text":"*'"$HOST"' ( '"$IP"' )*", "attachments" : [{"pretext": "'"$NOTICE"'", "color": "warning", "text": "'"$UPDATES"'"}]}' $HOOK
fi