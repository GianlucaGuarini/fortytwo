VERSION:=$(v)

install:
	@ stack install

test:
	@ stack test

build:
	@ stack build

release:
	@ sed -i '' 's/\(^version:\)[^\n].*/\1'$(VERSION)'/' *.cabal
	@ stack sdist
	@ stack upload .

.PHONY: install test build release
