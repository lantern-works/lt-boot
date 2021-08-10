MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
TAG?=latest
OS_IMAGE?=ArchLinuxARM-rpi-latest.tar.gz
OS_URI?=http://archlinuxarm.org/os/$(OS_IMAGE)
DATE := $(shell date +%s)
IMAGE_SIZE?=3G
IMAGE_NAME := lt

.PHONY: build precache

precache:
	# prepares the arch linux packages
	# to avoid duplicate downloads
	# and to speed up the build process

	# // build precache image
	docker build -f ./pre/dockerfile --build-arg CACHEBUST="${DATE}" -t "${IMAGE_NAME}-precache:${TAG}"  .
			
	# // run precache image
	docker run -it  \
	--pull=false \
	--volume ${PWD}/pre:/opt \
	--volume ${PWD}/pre/pkg:/var/cache/pacman/pkg \
	-m 512M \
	"${IMAGE_NAME}-precache:${TAG}"
	
build:
	docker build -f ./dockerfile \
		--platform linux/amd64 \
		--build-arg CACHEBUST="${DATE}" -t "${IMAGE_NAME}:${TAG}"  .

run:
	docker run -it  \
	--volume ${PWD}/src:/tmp \
	-m 512M \
	"${IMAGE_NAME}:${TAG}"

pi:
	docker pull westlane/pi-maker
	docker run -it --privileged \
		--volume ${PWD}/src:/tmp \
		--platform linux/amd64 \
		-e OS_IMAGE="$(OS_IMAGE)" \
		-e OS_URI="$(OS_URI)" \
		-e COPY_DIR="/tmp/platform" \
		-e SCRIPT_DIR="/tmp/install" \
		-e SETUP_SCRIPT="/tmp/setup.sh" \
		-e IMAGE_SIZE=$(IMAGE_SIZE) \
		"westlane/pi-maker:${TAG}"