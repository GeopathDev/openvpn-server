#! /bin/bash

sudo ()
{
  [ $UID = 0 ] || set -- command sudo "$@"
  "$@"
}

cd "$HOME/openvpn-ca" || exit 1

source ./vars

CRL="crl.pem"

if [ "$KEY_DIR" ]; then
  cd "$KEY_DIR" || exit 1

  export KEY_CN=""
  export KEY_OU=""
  export KEY_NAME=""
  export KEY_ALTNAMES=""

  $OPENSSL ca -gencrl -out "$CRL" -config "$KEY_CONFIG"

else
  echo 'UNABLE TO ACCESS VARS'
  exit 1
fi

sudo cp "$KEY_DIR/$CRL" /etc/openvpn