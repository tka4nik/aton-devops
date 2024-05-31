#!/bin/bash

source config.sh

DISK_SPACE=$(df -h --total | grep total | awk '{print $5}' | sed 's/%//')

if [[ $DISK_SPACE -le $THRESHOLD ]]; then
    SUBJECT="Disk Space Alert: Disk is ${DISK_SPACE}% full"
    echo "$SUBJECT"
    MESSAGE="Warning: The disk usage on $DISK has reached ${DISK_SPACE}%."

    echo -e "Subject:$SUBJECT\n\n$MESSAGE" | msmtp --host=$SMTP_SERVER --port=$SMTP_PORT --auth=on --user=$SMTP_USER --password=$SMTP_PASS --from=$EMAIL_FROM -t $EMAIL_TO
fi

