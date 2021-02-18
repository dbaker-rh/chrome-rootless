#!/bin/bash

# Hackery ahead -- this is crude, but gets chrome operational for the
# time being.  We can pass in the xauth file more elegantly, I'm sure.
#
# We have $XAUTHORITY passed in, which is either a copy of our original,
# or perhaps a READ ONLY copy so we can't make edits to the file on the
# underlying host.
#

echo Running as
id -a

echo Incoming, XAUTHORITY is $XAUTHORITY
ls -l $XAUTHORITY

cp $XAUTHORITY $NEWXAUTH
export NEWXAUTH=$( mktemp )


# Hackery ahead -- we skip the first launch configuration options for
# chrome.
mkdir -p ~/.config/google-chrome/
touch ~/.config/google-chrome/"First Run"


# Reference pages for command line args:
# https://www.maketecheasier.com/useful-chrome-command-line-switches/
# https://www.ghacks.net/2013/10/06/list-useful-google-chrome-command-line-switches/
# https://peter.sh/experiments/chromium-command-line-switches/


google-chrome --disable-sync --disable-notifications --mute-audio

