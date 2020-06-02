#!/usr/bin/env bash
image_name=dhet/debezium-connect

for tag in $(echo "$@" | tr "," "\n")
do
  echo "===> Building image with tag '$tag'"
  sed -e "s/{{tag}}/${tag}/g" docker/Dockerfile.template > docker/Dockerfile
  docker build -t "$image_name:$tag" -t $image_name:latest docker

  echo "===> Pushing image with tag '$tag'"
  docker push "$image_name:$tag"
done
