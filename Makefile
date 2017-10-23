VERSION:=$(v)

install:
	@ stack install

test:
	@ stack test

demo:
	@ stack exec examples

build:
	@ stack build

release:
	@ git tag $(VERSION)
	@ git push --tags
	@ sed -i '' 's/\(^version:\)[^\n].*/\1'$(VERSION)'/' *.cabal
	@ stack sdist
	@ stack upload .

.PHONY: install test demo build release
