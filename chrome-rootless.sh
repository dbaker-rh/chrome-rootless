#!/bin/sh

# Chrome inside rootless podman container
#   https://github.com/dbaker-rh/chrome-rootless


## Setting "none" is useful for other rootless apps to prevent
## them from making any outbound network connections -- not suitable
## for Chrome, though.

#NETWORK=none
NETWORK=slirp4netns

# This is needed to give Chrome enough memory to render complex pages
SHMSIZE=4G

podman run --rm \
     --net=$NETWORK \
     -e DISPLAY -e XAUTHORITY \
     --volume="$XAUTHORITY:$XAUTHORITY:ro" \
     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
     --privileged \
     --shm-size=$SHMSIZE \
     --name chrome-rootless \
           chrome-rootless


