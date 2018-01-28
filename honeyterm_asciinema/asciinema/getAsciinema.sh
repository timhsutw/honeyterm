#!/bin/bash

DIRECTORY=/tmp/honeypot

if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
fi

IFS=', ' read -r -a array <<< `docker ps --format "{{.Names}}"`

for element in "${array[@]}"
do
    docker cp "$element":/tmp/asciinema.json "$DIRECTORY/$element".json > /dev/null 2>&1
done
