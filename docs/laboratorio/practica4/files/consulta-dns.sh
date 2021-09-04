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

# Consulta registo TXT para ACME

TYPE=TXT
NAME=_acme-challenge.${DOMAIN}.
printf "\n\t==> %s (%s) <==\n\n" "${NAME}" "${TYPE}"
dig ${TYPE} ${NAME} 2>&1

# Consulta registros de VirtualHosts

TYPE=A
for NAME in \
           ${DOMAIN}. \
      docs.${DOMAIN}. \
    manual.${DOMAIN}. \
     sitio.${DOMAIN}. \
  estatico.${DOMAIN}.
do
  printf "\n\t==> %s (%s) <==\n\n" "${NAME}" "${TYPE}"
  dig ${TYPE} ${NAME} 2>&1
done

