#!/usr/bin/env bash

# Publishes images to Docker Hub

# We expect this repo to one day contain multiple useful Coder images, but currently it
# only has one option, 'base'. To keep tag names coherent, we're providing three ways to
# reference variants:
#   * by release number and variant name (e.g. harrisonai/coder-dev:0.1.0-base),
#   * by variant name alone (e.g. harrisonai/coder-dev:base, which will always use the
#     most recent release), and
#   * by default/latest, which will always be the most recent release of 'base'.

set -e

if [ "$#" -ne 2 ]; then
    >&2 echo "Usage: $(basename $0) <image-name> <version-tag>"
    exit 1
fi

IMAGE_NAME="$1"
VERSION="${2#v}"

echo "🏷️ Adding additional tags for image '${IMAGE_NAME}:base': ${VERSION}-base, latest"
docker tag "${IMAGE_NAME}:base" "${IMAGE_NAME}:${VERSION}-base"
docker tag "${IMAGE_NAME}:base" "${IMAGE_NAME}:latest"

echo "📤 Pushing '${IMAGE_NAME}:${VERSION}-base', '${IMAGE_NAME}:base', and '${IMAGE_NAME}:latest'"
docker push "${IMAGE_NAME}:${VERSION}-base"
docker push "${IMAGE_NAME}:base"
docker push "${IMAGE_NAME}:latest"
