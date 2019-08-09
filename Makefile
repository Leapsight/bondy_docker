REBAR = prod

.PHONY: develop-slim


develop-slim:
	docker build --build-arg BONDY_TAG=develop -t bondy:test -f Dockerfile.slim .

