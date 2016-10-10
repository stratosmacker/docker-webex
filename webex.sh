#!/bin/sh

docker rm --force webex >/dev/null 2>&1
docker build --tag=webex .
xhost local:root
docker run -ti \
	--env DISPLAY=unix$DISPLAY \
	--privileged \
        --name=webex \
	--volume /dev/snd:/dev/snd \
	--volume /tmp/.X11-unix:/tmp/.X11-unix \
	webex $1
