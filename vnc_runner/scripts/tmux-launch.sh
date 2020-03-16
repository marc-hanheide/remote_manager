#!/bin/bash

TC="tmux send-keys -t remote_ngrok_vnc "
TWIN="tmux new-window -t remote_ngrok_vnc"

tmux kill-session -t remote_ngrok_vnc || true
tmux new -s remote_ngrok_vnc -d

$TWIN
$TC 'VNC_OPTS="-scale 1280x768"' C-m
$TC 'VNC_PORT="5910"' C-m
$TC 'export DISPLAY=:0' C-m
$TC 'cd `dirname "$0"/..`' C-m
$TC 'x11vnc -forever -shared -xkb -localhost $VNC_OPTS -rfbport $VNC_PORT 2>&1' C-m


$TWIN
$TC 'while true; do' C-m C-m
$TC '	default_dev=$(ip route get 8.8.8.8 | grep dev | cut -f5 -d" ")' C-m
$TC '	mac=$(ip link show $default_dev | grep link/ether | sed "s@^[^0-9]*\([0-9a-f:]*\).*\$@\1@" | tr -d ":")' C-m
$TC '	pw=$(echo $mac|md5sum|cut -f1 -d" ")' C-m
$TC '	ngrok1 -subdomain=$mac -httpauth "$mac:$pw" -proto https -log=stdout 6080 || ngrok -subdomain=$mac -httpauth "$mac:$pw" -proto https -log=stdout 6080' C-m
$TC '	sleep 10' C-m
$TC 'done'  C-m

$TWIN
$TC 'VNC_PORT="5910"' C-m
$TC './noVNC/utils/launch.sh --vnc localhost:$VNC_PORT' C-m


$TWIN
$TC 'while true; do' C-m C-m
$TC '	default_dev=$(ip route get 8.8.8.8 | grep dev | cut -f5 -d" ")' C-m
$TC '	mac=$(ip link show $default_dev | grep link/ether | sed "s@^[^0-9]*\([0-9a-f:]*\).*\$@\1@" | tr -d ":")' C-m
$TC '	pw=$(echo $mac|md5sum|cut -f1 -d" ")' C-m
$TC '   wget -O /tmp/iptracker.sh https://raw.githubusercontent.com/marc-hanheide/network-scripts/master/iptracker.sh' C-m
$TC '   bash /tmp/iptracker.sh -n "vnclab-$mac"' C-m
$TC '	sleep 120' C-m
$TC 'done'  C-m


