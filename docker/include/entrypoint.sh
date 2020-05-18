#!/usr/bin/env bash

/setup/initialize.sh &

exec /docker-entrypoint.sh "start"