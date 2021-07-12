SHELL = /usr/bin/env bash

SOURCE_FILES = $(shell fd . pages/ --no-ignore)


.PHONY: build publish clean

build: .build_sentinel

publish: build
	./publish-website

clean:
	rm -rf build


.build_sentinel: ${SOURCE_FILES} pages/
	mkdir -p build
	./mksite
