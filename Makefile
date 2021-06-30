# .PHONY: develop-slim develop 0.9-SNAPSHOT

BONDY_TAG=""
IMAGE_NAME = $(shell echo $(BONDY_TAG) | tr A-Z a-z)

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

build-tag:
ifeq ($(BONDY_TAG), "")
	@echo "Error BONDY_TAG environment variable not defined."
	@echo "Usage: 'make BONDY_TAG=release/0.9.0-SNAPSHOT'"
else

	docker stop "$(IMAGE_NAME)" || true
	docker rm "$(IMAGE_NAME)" || true
	docker rmi "$(IMAGE_NAME)" || true
	docker build \
		--build-arg "BONDY_TAG=$(BONDY_TAG)" \
		--pull \
		-t "$(IMAGE_NAME)" \
		-f 0.9-SNAPSHOT/Dockerfile .
endif

run-tag:
ifeq ($(BONDY_TAG), "")
	@echo "Error BONDY_TAG environment variable not defined."
	@echo "Usage: 'make run-tag BONDY_TAG=release/0.9.0-SNAPSHOT'"
else
	docker stop "$(IMAGE_NAME)" || true
	docker rm "$(IMAGE_NAME)" || true
	docker run \
		-e BONDY_ERL_NODENAME=bondy1@127.0.0.1 \
		-e BONDY_ERL_DISTRIBUTED_COOKIE=bondy \
		-p 18080:18080 \
		-p 18081:18081 \
		-p 18082:18082 \
		-p 18086:18086 \
		-v "$(PWD)/examples/custom_config/etc:/bondy/etc" \
		--name "bondy" \
		-d "$(IMAGE_NAME)"
endif

scan-tag:
ifeq ($(BONDY_TAG), "")
	@echo "Error BONDY_TAG environment variable not defined."
	@echo "Usage: 'make scan-tag BONDY_TAG=release/0.9.0-SNAPSHOT'"
else
	docker scan "$(IMAGE_NAME)"
endif

build-latest:
	docker stop bondy-latest || true
	docker rm bondy-latest || true
	docker rmi bondy-latest || true
	docker build \
		--build-arg BONDY_TAG=release/0.9.0-SNAPSHOT \
		--pull \
		-t "bondy-latest" \
		-f 0.9-SNAPSHOT/Dockerfile .

run-latest:
	docker stop bondy-latest || true
	docker rm bondy-latest || true
	docker run \
		--rm \
		-e BONDY_ERL_NODENAME=bondy1@127.0.0.1 \
		-e BONDY_ERL_DISTRIBUTED_COOKIE=bondy \
		-p 18080:18080 \
		-p 18081:18081 \
		-p 18082:18082 \
		-p 18086:18086 \
		-v "$(PWD)/examples/custom_config/etc:/bondy/etc" \
		--name bondy-latest \
		-d bondy-latest


scan-latest:
	docker scan bondy-latest