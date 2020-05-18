#!/usr/bin/env bash
image_name=dhet/debezium-connect
tag=$1

if [[ $# -ne 1 ]] ; then
  echo "Please specify an image tag."
  exit
fi

sed -e "s/{{tag}}/${tag}/g" docker/Dockerfile.template > docker/Dockerfile

docker build -t $image_name:$1 -t $image_name:latest docker
docker push $image_name:$1
docker push $image_name:latest
