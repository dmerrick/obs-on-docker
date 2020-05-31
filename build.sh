#!/usr/bin/env bash

set -ex

NAME="obs-on-docker"

docker build -t $NAME .
