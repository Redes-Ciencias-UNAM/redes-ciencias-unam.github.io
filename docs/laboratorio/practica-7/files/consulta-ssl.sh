#!/bin/bash
set -e
#	= ^ . ^ =
# Revisa si se proporcionó un nombre de dominio como argumento
# TODO: Validar contra una expresión regular
if [ -z "${1}" ]
then
  cat << EOF

Uso: ${0} <dominio>

EOF
  exit -1
else
  DOMAIN="${1}"
fi

# Obtén la IP del host principal
HOST_IP=$(dig +short A ${DOMAIN}.)

# Revisa los certificados que regresa cada VirtualHost

for NAME in \
          ${HOST_IP} \
           ${DOMAIN} \
      docs.${DOMAIN} \
    manual.${DOMAIN} \
     sitio.${DOMAIN} \
  estatico.${DOMAIN}
do
  printf "\n\t==> %s <==\n\n" "${NAME}"
  openssl s_client -showcerts -x509_strict -connect ${NAME}:443 < /dev/null 2>&1
done
