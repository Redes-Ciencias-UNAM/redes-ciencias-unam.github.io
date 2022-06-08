# syntax=docker/dockerfile:1.4

################################################################################

FROM	docker.io/library/debian:11 AS debian

ENV	DEBIAN_FRONTEND=noninteractive

COPY	<<EOF  /etc/apt/apt.conf.d/99-local
quiet "2";
APT::Get::Assume-Yes "1";
APT::Install-Recommends "0";
APT::Install-Suggests "0";
APT::Color "0";
Dpkg::Progress "0";
Dpkg::Progress-Fancy "0";
EOF

RUN	apt update && \
	apt install linux-doc

################################################################################

FROM	docker.io/library/nginx:1.22-alpine AS app

ENV	NGINX_ROOT=/usr/share/nginx/html \
	LINUX_DOC_ROOT=/usr/share/doc/linux-doc/html

COPY	--from=debian ${LINUX_DOC_ROOT} ${NGINX_ROOT}
