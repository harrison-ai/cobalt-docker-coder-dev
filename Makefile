
.DEFAULT_GOAL := help
IMAGE_NAME := harrisonai/coder-dev

build:
	./scripts/build.sh $(IMAGE_NAME)

publish:
	@test -n "${TAG}" || ( echo "TAG environment variable must be set" && return 1 )
	./scripts/publish.sh $(IMAGE_NAME) ${TAG}

help:
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
