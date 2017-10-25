VERSION:=$(v)

install:
	@ stack install

test:
	@ stack test

demo:
	@ stack build --flag fortytwo:demos
	@ stack exec demo

build:
	@ stack build

release:
	#@ sed -i '' 's/\(^version:\)[^\n].*/\1'$(VERSION)'/' *.cabal
	#@ stack sdist
	#@ stack upload .
	@ git add .
	@ git commit -m 'v$(VERSION)'
	@ git tag $(VERSION)
	@ git push --tags

.PHONY: install test demo build release
