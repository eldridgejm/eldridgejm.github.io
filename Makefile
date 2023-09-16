SHELL = /usr/bin/env bash

SOURCE_FILES = $(shell fd . pages/ --no-ignore)


.PHONY: build clean

build: .build_sentinel

clean:
	rm -rf build

.build_sentinel: ${SOURCE_FILES} pages/
	mkdir -p build
	./bin/mksite
