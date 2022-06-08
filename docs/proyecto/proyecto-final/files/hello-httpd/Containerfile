# syntax=docker/dockerfile:1.4

FROM	docker.io/library/httpd:2.4-alpine AS httpd

ENV	DOCUMENT_ROOT=/usr/local/apache2/htdocs

COPY	<<EOF ${DOCUMENT_ROOT}/index.html
<html>
  <head>
    <title>Hello world!</title>
  </head>
  <body>
    <h1>It works!</h1>
  </body>
</html>
EOF
