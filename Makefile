DOCKER_IMAGE_NAME ?= ghcr.io/bornholm/marker-pdf
MARKER_PDF_VERSION ?= 1.6.2

build:
	docker build \
		--build-arg MARKER_PDF_VERSION=$(MARKER_PDF_VERSION) \
		-t $(DOCKER_IMAGE_NAME):latest \
		.

run: build
	docker volume create marker_pdf_cache
	docker run \
		--name marker-pdf \
		-it \
		--rm \
		-v marker_pdf_cache:/root/.cache \
		-p 8001:8001 \
		$(DOCKER_IMAGE_NAME):latest

release: build
	docker tag $(DOCKER_IMAGE_NAME):latest $(DOCKER_IMAGE_NAME):$(MARKER_PDF_VERSION)
	docker push $(DOCKER_IMAGE_NAME):$(MARKER_PDF_VERSION)

purge:
	docker volume rm marker_pdf_cache