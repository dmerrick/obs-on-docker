#!/usr/bin/env bash

set -ex

NAME="$1"

docker exec -it \
  -e USER=root \
  $NAME \
  bash
