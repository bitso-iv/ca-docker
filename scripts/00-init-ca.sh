#!/bin/bash
set -e
cd /pki

if [ -f ca/certs/ca.crt ]; then
  echo "CA уже создан, пропускаю"
  exit 0
fi

echo "=== Создаём Root CA ==="
openssl req -x509 -new -nodes -keyout ca/private/ca.key -sha256 -days 3650 \
  -subj "/C=UZ/O=Lab/CN=Lab Root CA" -out ca/certs/ca.crt

echo "=== Инициализируем базу CA (для Участника 2) ==="
touch db/index.txt
echo 1000 > db/serial
echo 1000 > db/crlnumber

echo "=== Создаём конфиг openssl ca ==="
cat > config/ca.cnf <<EOF
[ ca ]
default_ca = CA_default

[ CA_default ]
dir             = /pki
database        = \$dir/db/index.txt
serial          = \$dir/db/serial
new_certs_dir   = \$dir/db/newcerts
certificate     = \$dir/ca/certs/ca.crt
private_key     = \$dir/ca/private/ca.key
default_md      = sha256
default_days    = 365
policy          = policy_loose
crlnumber       = \$dir/db/crlnumber
crl_extensions  = crl_ext
default_crl_days = 30

[ policy_loose ]
countryName             = optional
organizationName        = optional
commonName              = supplied

[ crl_ext ]
authorityKeyIdentifier=keyid:always
EOF

chmod 600 ca/private/ca.key
echo "=== Готово. CA создан, база инициализирована ==="