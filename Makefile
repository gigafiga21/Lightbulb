.PHONY: docker check

# Absolte path to the root of the repository
ROOT := $(shell git rev-parse --show-toplevel)

# Builds docker `lightbulb-builder` image
# Run it's container
docker:
	docker build -t lightbulb-builder .
	docker run -it \
		--name lightbulb \
		--mount type=bind,source="$(ROOT)",destination=/lightbulb \
		lightbulb-builder
