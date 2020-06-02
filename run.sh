#!/usr/bin/env bash

set -ex

NAME="obs-on-docker"

# sudo apt install nvidia-container-runtime
docker run -it --rm \
  --runtime=nvidia \
  --privileged \
  -p 5900:5900 \
  -p 5901:5901 \

# bind container port 5900 to local 5902 (vnc)
# bind container port 5901 to local 5980 (http)
# docker run -it --rm \
#   --shm-size=256m \
#   -e VNC_PASSWD=123456 \
#   -p 5902:5900 \
#   -p 5980:5901 \
#   $NAME

#TODO: tail the obs log here?
#  tail -f /root/.config/obs-studio/logs/*.txt
