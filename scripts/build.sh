#!/usr/bin/env bash

# Builds the docker images

set -e

if [ "$#" -ne 1 ]; then
    >&2 echo "Usage: $(basename $0) <image-name>"
    exit 1
fi

IMAGE_NAME="$1"

docker build -t "${IMAGE_NAME}:base" base
