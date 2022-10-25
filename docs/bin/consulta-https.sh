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

# Consulta registros de VirtualHosts

TYPE=A
for NAME in \
          ${HOST_IP} \
           ${DOMAIN} \
      docs.${DOMAIN} \
    manual.${DOMAIN} \
     sitio.${DOMAIN} \
  estatico.${DOMAIN}
do
  for PROTO in http https
  do
    printf "\n\t==> %s (%s) <==\n\n" "${NAME}" "${PROTO}"
    curl -vk#L -o /dev/null "${PROTO}://${NAME}/" 2>&1
  done
done
