#!/usr/bin/make -f
#	= ^ . ^ =
SHELL=/bin/bash

MKDOCS=mkdocs

default:	serve
test:	build

install:
	which ${MKDOCS} || \
	pip3 install --user --requirement requirements.txt

build:	install
	${MKDOCS} $@ --strict


serve:	install
	${MKDOCS} $@ --strict --verbose
