#!/bin/bash

set -e

cd /data

cp -rf /tmp/ftb/* .
echo "eula=true" > eula.txt

if [[ ! -e server.properties ]]; then
    cp /tmp/server.properties .
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$FLIGHT" ]]; then
	sed -i "/allow-flight\s*=/ c allow-flight=$FLIGHT" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

if [[ -n "$WL" ]]; then
    echo $WL | awk -v RS=, '{print}' >> whitelist.txt
fi

sleep 20

bash ./ServerStart.sh
