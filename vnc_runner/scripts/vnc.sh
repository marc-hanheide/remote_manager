#!/bin/bash

x11vnc -forever -shared -xkb -localhost $VNC_OPTS $VNC_PORT
