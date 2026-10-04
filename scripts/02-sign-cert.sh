#!/bin/bash
set -e
cd /pki

NAME=$1
if [ -z "$NAME" ]; then
  echo "Использование: 02-sign-cert.sh <имя>"
  exit 1
fi

if [ ! -f users/$NAME/$NAME.csr ]; then
  echo "Ошибка: нет файла users/$NAME/$NAME.csr. Сначала запусти 01-new-request.sh $NAME"
  exit 1
fi

openssl ca -config config/ca.cnf -in users/$NAME/$NAME.csr \
  -out users/$NAME/$NAME.crt -batch

echo "=== Сертификат подписан: users/$NAME/$NAME.crt ==="
openssl verify -CAfile ca/certs/ca.crt users/$NAME/$NAME.crt