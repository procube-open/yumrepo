#!/bin/bash
echo "Setting up yum repository.";
make

_term() {
  echo "Send SIGTERM to Web Server."
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

echo "Start Web server.";
httpd -D FOREGROUND &

child=$!
wait "$child"
echo "Waiting for Web Server Shutdown."
wait "$child"
echo "Shutdown Complete."
exit 0
