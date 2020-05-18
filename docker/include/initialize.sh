#!/usr/bin/env bash

echo "===> Building Debezium config from env vars ..."
python /setup/build_config.py

echo "===> Config:
$(cat debezium_config.json)"

echo "===> Waiting for connector to start ..."
sleep 30

echo "===> Posting Debezium config to the connector ..."

curl -X PUT -sS \
  -H "Accept:application/json" \
  -H "Content-Type:application/json" \
  -d @debezium_config.json \
  --retry 100 --retry-delay 10 --retry-max-time 60 \
  "http://${CONNECT_REST_ADVERTISED_HOST_NAME}:${CONNECT_REST_PORT}/connectors/${CONNECTOR_NAME}/config"

echo "===> Successfully configured Debezium connector ..."
