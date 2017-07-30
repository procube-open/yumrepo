#!/bin/bash
if [ -z "$REPO_NAME" ]; then
	echo "ERROR: REPO_NAME Environment Variable must be set"
  exit 1
fi
if [ -z "$EMAIL" ]; then
	echo "ERROR: EMAIL Environment Variable must be set"
  exit 1
fi
PASSPHRASE=${PASSPHRASE:-$(head -c 12 /dev/urandom | base64)}
mkdir -p ${HOME}/.gnupg
cat > ${HOME}/.gnupg/gpg-rpmsign <<__EOF
%echo Generating a basic OpenPGP key
Key-Type: default
Key-Length: 2048
Name-Real: ${REPO_NAME}
Name-Comment: for signing rpms of the $REPO_NAME
Name-Email: ${EMAIL}
Expire-Date: 0
Passphrase: ${PASSPHRASE}
%commit
%echo done
__EOF
gpg2 --batch --gen-key ${HOME}/.gnupg/gpg-rpmsign
