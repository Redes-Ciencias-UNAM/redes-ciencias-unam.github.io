# syntax=docker/dockerfile:1.4

################################################################################

FROM	docker.io/library/python:3.10-alpine AS python

WORKDIR	/srv

ENV	GIT_PROJECT=Redes-Ciencias-UNAM/2022-2 \
	GIT_REPO=tareas-redes \
	GIT_BRANCH=entregas

ENV	ARCHIVE_FILE=${GIT_REPO}.tar.gz \
	GITLAB_URL="https://gitlab.com/${GIT_PROJECT}/${GIT_REPO}/-/archive/${GIT_BRANCH}/${GIT_REPO}-${GIT_BRANCH}.tar.gz"

RUN	wget -c -q -O ${ARCHIVE_FILE} ${GITLAB_URL} && \
	ls -l ${ARCHIVE_FILE} && \
	tar -xvzf ${ARCHIVE_FILE} --strip 1 && \
	rm -v ${ARCHIVE_FILE} && \
	pip3 config --global set global.progress_bar off && \
	pip3 install --upgrade pip && \
	pip3 install --requirement requirements.txt && \
	which mkdocs && \
	mkdocs build --strict && \
	ls -la .

################################################################################

FROM	docker.io/library/nginx:1.22-alpine AS app

ENV	NGINX_ROOT=/usr/share/nginx/html \
	MKDOCS_ROOT=/srv/public

COPY	--from=python ${MKDOCS_ROOT} ${NGINX_ROOT}
