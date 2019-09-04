# Chrome, rootless, on RHEL8

## Prep local machine to enable running rootless

To run rootless on RHEL8 you will probably need packages from the nightly
repos for at least a while longer.

   sudo dnf --enablerepo=*nightly* update \
        runc podman podman-docker slirp4netns \
        containernetworking-plugins container-selinux

NOTE: Use "dnf list | grep nightly" to look for other packages installed
via nightly repos which may also need updating.


## Building

   podman build . -t chrome-rootless


## Running

   ./chrome-rootless.sh


## X11 / Wayland / etc

Contrary to various things found online, running the graphical app inside
the container is not as complicated as it appears at first.

We pass $DISPLAY (as is) and also /tmp/.X11-unix through to the container,
which lets the application know where it will try to display the interface.

Running as non-root makes this more complicated as we need a locally
writable XAUTHORITY file, so (currently) perform some hackery to make it so.



## Data files

All data files (cache, bookmarks, etc) are lost between runs and intended
to not be preserved.


