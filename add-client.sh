#!/usr/bin/env bash

# Change to script directory
sd=`dirname $0`
cd $sd

name=$1
ovpn_client_file_name=$2

if [ "$name" = "" ]; then
  echo "Usage: add-client.sh name"
  exit;
fi

# Generate a client certificate and key pair
$sd/generate-client-certificate.sh $name

# Make config
$sd/make-config.sh $name $ovpn_client_file_name
