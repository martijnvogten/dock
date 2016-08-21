#!/bin/sh
LOCAL_PORT=8306

while [ -n "$(lsof -t -i :$LOCAL_PORT)" ] ; do
	LOCAL_PORT=$(expr $LOCAL_PORT + 1)
done

set -e
echo "Opening SSH tunnel on local port $LOCAL_PORT"

REMOTE_PORT=$(ssh $DOCKER_SSH docker port $1 | grep '3306/tcp' | grep -oE '\S+$')
ssh -q -fN -L $LOCAL_PORT:$REMOTE_PORT $DOCKER_SSH &

SPF_FILE=$TMPDIR$1_tunnel_$LOCAL_PORT.spf
sed "s/8306/$LOCAL_PORT/" $DOCK_HOME/sequel\ Pro/tunnel.spf | \
 sed "s/_DATABASE/$2/" | \
 sed "s/_TABLE/$3/" > $SPF_FILE

open -n -W $SPF_FILE

kill $(lsof -t -i :$LOCAL_PORT )
