build:
	coffee -c -o dist src/*.coffee
install:
	bower install
.PHONY: build