#!/usr/bin/env bash

# enable buildkit
# https://www.docker.com/blog/faster-builds-in-compose-thanks-to-buildkit-support/
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

set -ex

NAME="obs-on-docker"

docker build -t $NAME -f Dockerfile.new .
