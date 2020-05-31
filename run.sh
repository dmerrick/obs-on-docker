#!/usr/bin/env bash

set -ex

NAME="obs-on-docker"

docker run -it --rm \
  -v /data:/data \
  -p 5901:5901 \
  -e USER=root \
  $NAME \
  bash -c "vncserver :1 -geometry 1920x1080 -depth 24 && tail -F /root/.vnc/*.log"
