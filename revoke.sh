#!/bin/bash

CERT_FILE="${1}"
shift

if [[ -z ${CERT_FILE} ]]; then
    echo "usage: ${0} <certificate file>"
    exit 0
fi

CERT_JSON="$(cfssl certinfo -cert "${CERT_FILE}")"

SERIAL="$(jq -r '.serial_number' <<<"${CERT_JSON}")"
AKI="$(jq -r '.authority_key_id' <<<"${CERT_JSON}" | sed -e 's/://g' | tr 'A-Z' 'a-z')"

JSON_DATA="{\"serial\":\"${SERIAL}\",\"authority_key_id\":\"${AKI}\",\"reason\":\"privilegewithdrawn\"}"

echo "${JSON_DATA}" | jq .

curl \
 -sSL \
 -X POST \
 -H "Content-Type: application/json" \
 -d "${JSON_DATA}" \
 http://127.0.0.1:8888/api/v1/cfssl/revoke | jq .
