#!/bin/bash
echo "Setting up yum repository.";
make

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

echo "Start Web server.";
httpd -D FOREGROUND &

child=$!
wait "$child"
