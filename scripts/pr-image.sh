#!/usr/bin/env bash

# Push images built off a PR to Github Container Registry

set -e

if [ "$#" -ne 2 ]; then
    >&2 echo "Usage: $(basename $0) <image-name> <branch-tag>"
    exit 1
fi

IMAGE_NAME="$1"
BRANCH=$(echo "${2}" | sed 's/\//-/g')

echo "🏷️ Setting tags for image '${IMAGE_NAME}:${BRANCH}-prbase"
docker tag "${IMAGE_NAME}:base" "${IMAGE_NAME}:${BRANCH}-prbase"

echo "📤 Pushing '${IMAGE_NAME}:${BRANCH}-prbase'"
docker push "${IMAGE_NAME}:${BRANCH}-prbase"
