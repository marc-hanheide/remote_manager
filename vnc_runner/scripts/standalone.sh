#!/bin/bash


VNC_OPTS="-scale 1280x768"
VNC_PORT="5910"

cd `dirname "$0"/..`

x11vnc -forever -shared -xkb -localhost $VNC_OPTS -rfbport $VNC_PORT 2>&1 | tee x11vnc.log &

X11VNC_PID="$!"

echo "$X11VNC_PID"

./noVNC/utils/launch.sh --vnc localhost:$VNC_PORT

kill "$X11VNC_PID"

sleep 1

kill -9 "$X11VNC_PID"


