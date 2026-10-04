#!/bin/bash
set -e
cd /pki

NAME=$1
if [ -z "$NAME" ]; then
  echo "Использование: 01-new-request.sh <имя>"
  exit 1
fi

if [ ! -d "users/$NAME" ]; then
  echo "Ошибка: папки users/$NAME не существует. Создай её заранее на Windows: mkdir pki\\users\\$NAME"
  exit 1
fi

openssl req -new -nodes -keyout users/$NAME/$NAME.key \
  -subj "/C=UZ/O=Lab/CN=$NAME" -out users/$NAME/$NAME.csr

echo "=== CSR создан: users/$NAME/$NAME.csr ==="