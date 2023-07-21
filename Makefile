UID := $(shell id -u)
GID := $(shell id -g)
USER := $(shell id -un)
CURRENT_HASH := $(shell echo $$(git symbolic-ref --short HEAD 2> /dev/null || git rev-parse --short HEAD) | sed 's@/@-@g' | tr '[:upper:]' '[:lower:]')
PROJECT_NAME := $(USER)_$(CURRENT_HASH)

gradient_gym:
	COMPOSE_PROJECT_NAME=$(PROJECT_NAME) UID=$(UID) GID=$(GID) docker compose up gradient_gym --force-recreate --build --detach
