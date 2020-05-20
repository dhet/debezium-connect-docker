#!/usr/bin/env bash

initialize() {
  echo "===> Building connector config from env vars ..."
  python /setup/build_config.py

  echo "===> Uploading config to connector '${CONNECTOR_NAME}':"
  sed -e 's/\(.*password.*"\).*\("\)/\1*****\2/g' connector_config.json

  success=1
  while [ "$success" != "0" ]
  do
    sleep 5
    echo "===> Trying to upload connector config ..."
    curl -X PUT -fsS -o /dev/null \
      -H "Accept:application/json" \
      -H "Content-Type:application/json" \
      -d @connector_config.json \
      "http://${CONNECT_REST_ADVERTISED_HOST_NAME}:${CONNECT_REST_PORT}/connectors/${CONNECTOR_NAME}/config"

    success=$?
  done
  echo "===> Successfully configured connector '${CONNECTOR_NAME}'"
}

initialize & 

exec /docker-entrypoint.sh "start"