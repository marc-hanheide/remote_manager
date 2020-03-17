# Installation of VNC server for remote access

In order to provide easy remote access via VNC through a browser (using `x11vnc`, `NoVNC`, and `ngrok`)

## Installation

All this is assuming this repository has been cloned in to `~/remote_manager` via `git clone --recursive https://github.com/marc-hanheide/remote_manager.git`

1. Install dependencies:
    
    ```
    sudo apt update && sudo apt install x11vnc tmux
    ```
    
1. Make `ngrok v1.0` available in the `$PATH`, by installing it into `~/.local/bin`:
    
    ```
    mkdir -p ~/.local/bin
    install ~/remote_manager/network-scripts/bin/ngrok1.lnx ~/.local/bin
    ```

## Launching

1. go into the `vnc_runner` directory and just use the launch file

    ```
    cd ~/remote_manager/vnc_runner
    ./scripts/tmux-launch.sh
    ```

1. Now a tmux session (called `remote_ngrok_vnc`) has been created which can be attached to via `tmux a -t remote_ngrok_vnc` to see the output of the individual components.

