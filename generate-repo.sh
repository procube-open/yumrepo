#!/bin/sh
if [ -z "$REPO_NAME" ]; then
	echo "ERROR: REPO_NAME Environment Variable must be set"
  exit 1
fi
if [ -z "$FQDN" ]; then
  echo "ERROR: FQDN Environment Variable must be set"
  exit 1
fi
cat << __EOF
# [${REPO_NAME}-noarch]
# name=${REPO_NAME}
# baseurl=https://${FQDN}/${REPO_NAME}/noarch/
# gpgcheck=1
# gpgkey=https://${FQDN}/${REPO_NAME}/RPM-GPG-KEY-${REPO_NAME}
# enabled=1

[${REPO_NAME}-arch]
name=${REPO_NAME}
baseurl=https://${FQDN}/${REPO_NAME}/\$basearch/
gpgcheck=1
gpgkey=https://${FQDN}/${REPO_NAME}/RPM-GPG-KEY-${REPO_NAME}
enabled=1
__EOF
