#!/usr/bin/env bash

image_name=dhet/debezium-connect

docker login -u "$USER" -p "$PASSWORD"

for tag in "$@"
do
  echo "===> Building image with tag '$tag'"
  docker build --build-arg BASE_TAG="$tag" -t "$image_name:$tag" docker

  echo "===> Pushing image with tag '$tag'"
  docker push "$image_name:$tag"
done
