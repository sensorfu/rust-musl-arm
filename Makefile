REPOSITORY = sensorfu/rust-musl-arm

# Rust version dash our container version
VERSION = 1.27.1-0

build: Dockerfile
	docker build -t $(REPOSITORY):latest -f $< .
	docker tag $(REPOSITORY):latest $(REPOSITORY):$(VERSION)

push: build
	docker push $(REPOSITORY):latest
	docker push $(REPOSITORY):$(VERSION)

.PHONY: build push
