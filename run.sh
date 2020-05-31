#!/usr/bin/env bash

set -ex

NAME="obs-on-docker"

docker run -it --rm \
  -p 5900:5900 \
  -p 5901:5901 \
  $NAME
