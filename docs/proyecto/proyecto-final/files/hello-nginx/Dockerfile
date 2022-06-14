# syntax=docker/dockerfile:1.4

FROM	docker.io/library/nginx:1.22-alpine AS nginx

ENV	NGINX_ROOT=/usr/share/nginx/html

COPY	<<EOF ${NGINX_ROOT}/index.html
<html>
  <head>
    <title>Hello world!</title>
  </head>
  <body>
    <h1>It works!</h1>
  </body>
</html>
EOF
