#!/bin/bash
if [ -z "$FQDN" ]; then
  echo "ERROR: FQDN Environment Variable must be set"
  exit 1
fi
set -x
echo "ServerName $FQDN" > /etc/httpd/conf.d/servername.conf
make
exec httpd -D FOREGROUND
