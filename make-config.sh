#!/usr/bin/env bash

name=$1
ovpn_client_file_name=$2

if [ "$name" = "" ]; then
  echo "Usage: make-config.sh name"
  exit;
fi

KEY_DIR=$HOME/openvpn-ca/keys
OUTPUT_DIR=$HOME/client-configs/files
BASE_CONFIG=$HOME/client-configs/base.conf

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${name}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${name}.key \
    <(echo -e '</key>\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > > ${OUTPUT_DIR}/Geopath\ Staging\ VPN.ovpn

# sed -i "s/group nogroup/group nobody/" ${OUTPUT_DIR}/${name}.ovpn
