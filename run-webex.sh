#!/bin/bash

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH

# Ensure xauth has been created for :0
if ! xauth list | grep -q "$(hostname --short)/unix:0"; then
    touch ~/.Xauthority
    xauth add ${DISPLAY} . $(mcookie)
fi

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
xhost local:root

docker run -it \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY=$DISPLAY" \
        --user="webex" \
        --name=webex \
        --privileged \
        --net=host \
        --rm \
        webex
