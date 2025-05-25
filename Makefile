.DEFAULT_GOAL := build

clean:
	swift package clean

force-clean:
	rm -rf .build

build:
	swift build

build-release:
	swift build -c release

test:
	swift test

install: build-release
	install .build/release/plotty /usr/local/bin/
