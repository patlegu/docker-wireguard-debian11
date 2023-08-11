BUILDX=docker buildx build --platform linux/amd64,linux/arm64

.PHONY: base wireguard all pushall all-multi create-builder base-multi wireguard-multi delete-builder

all: base wireguard
all-multi: create-builder base-multi wireguard-multi delete-builder

pushall:
	docker push breizhland/base:debian11
	docker push breizhland/wireguard:debian11
	docker image tag breizhland/base:debian11 breizhland/base:latest
	docker push breizhland/base:latest
	docker image tag breizhland/wireguard:debian11 breizhland/wireguard:latest
	docker push breizhland/wireguard:latest

base:
	docker build -t breizhland/base:debian11 base

wireguard: base
	docker build -t breizhland/wireguard:debian11 wireguard

base-multi: create-builder
	$(BUILDX) -t breizhland/base:debian11 -t breizhland/base:latest --push base

wireguard-multi: create-builder base-multi
	$(BUILDX) -t breizhland/wireguard:debian11 -t breizhland/wireguard:latest --push wireguard

create-builder:
	docker buildx create --name kat-builder --use
	docker buildx inspect --bootstrap

delete-builder:
	docker buildx rm kat-builder
