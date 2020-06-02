#!/usr/bin/env bash

set -ex

NAME="obs-on-docker"

# sudo apt install nvidia-container-runtime
docker run -it --rm \
  --runtime=nvidia \
  --privileged \
  -p 5900:5900 \
  -p 5901:5901 \
  $NAME
#  tail -f /root/.config/obs-studio/logs/*.txt

#TODO: tail the obs log here?
