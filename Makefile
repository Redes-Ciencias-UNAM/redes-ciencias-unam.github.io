#!/usr/bin/make -f
SHELL=/bin/bash

MKDOCS=mkdocs

default:	test
test:	serve

install:
	which ${MKDOCS} || \
	pip3 install --user --requirement requirements.txt

build:	install
	${MKDOCS} $@ --strict --verbose 2>&1 | \
	grep -v '^DEBUG'

serve:	install
	${MKDOCS} $@ --strict
