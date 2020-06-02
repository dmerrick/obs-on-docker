#!/usr/bin/env bash

set -ex

NAME="obs-on-docker"

# sudo apt install nvidia-container-runtime
# docker run -it --rm \
#   --runtime=nvidia \
#   --privileged \
#   -p 5900:5900 \
#   $NAME

# bind container port 5900 to local 5902 (vnc)
docker run -it --rm \
  --shm-size=256m \
  -e VNC_PASSWD=123456 \
  --privileged \
  -p 5902:5900 \
  $NAME

#TODO: tail the obs log here?
#  tail -f /root/.config/obs-studio/logs/*.txt
