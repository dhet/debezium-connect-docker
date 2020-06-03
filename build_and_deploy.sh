#!/usr/bin/env bash
image_name=dhet/debezium-connect

docker login -u "$USER" -p "$PASSWORD"

for tag in "$@"
do
  echo "===> Building image with tag '$tag'"
  sed -e "s/{{tag}}/${tag}/g" docker/Dockerfile.template > docker/Dockerfile
  docker build -t "$image_name:$tag" -t $image_name:latest docker

  echo "===> Pushing image with tag '$tag'"
  docker push "$image_name:$tag"
done
