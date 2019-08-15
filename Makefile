.PHONY: develop-slim develop

develop:
	docker build \
	--build-arg BONDY_TAG=develop \
	-t bondy:test \
	--pull --rm --force-rm -f ./generic/Dockerfile .

develop-slim:
	docker build \
	--build-arg BONDY_TAG=develop \
	-t bondy:test \
	-f ./generic/slim/Dockerfile .

example-custom-config:
	docker build \
	-t bondy:example-custom-config \
	-f ./examples/custom_config/Dockerfile ./examples/custom_config/