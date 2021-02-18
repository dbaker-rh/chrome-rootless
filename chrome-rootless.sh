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


# Super ugly; take our XAUTH and copy it to a second file that we can
# chmod so the user inside of our container can read it.  We depend on
# the directory it's located in also being restricted to our current
# user for this to be a non-insane thing to consider.
cp ${XAUTHORITY} ${XAUTHORITY}.rw
chmod a+r ${XAUTHORITY}.rw

podman run --rm \
     --net=$NETWORK \
     -e DISPLAY -e XAUTHORITY \
     --volume="${XAUTHORITY}.rw:$XAUTHORITY:ro,z" \
     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
     --privileged \
     --shm-size=$SHMSIZE \
     --name chrome-rootless \
           chrome-rootless


