
REPOSITORY = sensorfu/rust-musl-arm
VERSION = 1.26.1

build: Dockerfile
	docker build -t $(REPOSITORY):latest -f $< .
	docker tag $(REPOSITORY):latest $(REPOSITORY):$(VERSION)

push: build
	docker push $(REPOSITORY):latest
	docker push $(REPOSITORY):$<-$(VERSION)

.PHONY: build push
