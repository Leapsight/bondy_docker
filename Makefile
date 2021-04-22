.PHONY: develop-slim develop 0.9-SNAPSHOT

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

0.9-SNAPSHOT:
	docker build --build-arg BONDY_TAG=feature/aramallo.otp23 --pull -t "leapsight/bondy:0.9-SNAPSHOT" -f 0.9-SNAPSHOT/Dockerfile .