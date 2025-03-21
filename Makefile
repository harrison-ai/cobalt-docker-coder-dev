
.DEFAULT_GOAL := help
IMAGE_NAME := ghcr.io/harrison-ai/coder-dev

build:
	./scripts/build.sh $(IMAGE_NAME)

run:
	docker run --rm -it $(IMAGE_NAME):base /bin/bash
	
publish:
	@test -n "${TAG}" || ( echo "TAG environment variable must be set" && return 1 )
	./scripts/publish.sh $(IMAGE_NAME) ${TAG}

pr-image:
	@test -n "${TAG}" || ( echo "TAG environment variable must be set" && return 1 )
	./scripts/pr-image.sh $(IMAGE_NAME) ${TAG}

help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
