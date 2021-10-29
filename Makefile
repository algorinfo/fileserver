define USAGE
Super awesome hand-crafted build system ⚙️

Commands:
	setup     Install dependencies, dev included
	lock      Generate requirements.txt
	test      Run tests
	lint      Run linting tests
	run       Run docker image with --rm flag but mounted dirs.
	release   Publish docker image based on DOCKERID
	docker    Build the docker image
	tag    	  Make a git tab using poetry information
endef

export USAGE
.EXPORT_ALL_VARIABLES:
VERSION := $(shell git describe --tags)
BUILD := $(shell git rev-parse --short HEAD)
DOCKERID := $(shell echo "nuxion")
PROJECTNAME := $(shell basename "$(PWD)")
PACKAGE_DIR = $(shell basename "$(PWD)")

help:
	@echo "$$USAGE"

.PHONY: lint
lint:
	echo "Running pylint...\n"
	pylint --disable=R,C,W $(PACKAGE_DIR)
	# echo "Running isort...\n"
	# isort --check $(PACKAGE_DIR)
	# echo "Running mypy...\n"
	# mypy $(PACKAGE_DIR)

.PHONY: test
test:
	curl -v -L -X PUT -d bigswag localhost:4444/wehave
	curl -v -L localhost:4444/wehave

.PHONY: run
run:
	docker run --rm -p 127.0.0.1:4444:4444 ${DOCKERID}/${PROJECTNAME}

.PHONY: docker
docker: 
	docker build -t ${DOCKERID}/${PROJECTNAME} .
	docker tag ${DOCKERID}/${PROJECTNAME} ${DOCKERID}/${PROJECTNAME}:latest
	docker tag ${DOCKERID}/${PROJECTNAME} ${DOCKERID}/${PROJECTNAME}:$(VERSION) 

.PHONY: release
release: 
	docker push ${DOCKERID}/$(PROJECTNAME):latest
	docker push ${DOCKERID}/$(PROJECTNAME):$(VERSION)
