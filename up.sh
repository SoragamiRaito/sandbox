#!/bin/bash

# Dockerイメージの名前とタグ
IMAGE_NAME="sandbox_ubuntu_image"
IMAGE_TAG="latest"

# コンテナの名前
CONTAINER_NAME="sandbox_ubuntu"

if docker images --format "{{.Repository}}" | grep -q "^${IMAGE_NAME}$"; then
  echo "The image already exists."
else
  echo "The image does not exist, performing the build..."
  . ./build.sh
fi

# コンテナが既に起動しているかを確認
if docker ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
  echo "Container '${CONTAINER_NAME}' is already running."
  if docker ps -f name="${CONTAINER_NAME}" -f status=exited | grep -q "^${CONTAINER_NAME}$"; then
    docker start "${CONTAINER_NAME}"
    echo "Container '${CONTAINER_NAME}' has been started."
  else
    echo "Container '${CONTAINER_NAME}' is not in an exited state."
  fi
else
  # コンテナを起動
  docker run -d --name "${CONTAINER_NAME}"  "${IMAGE_NAME}:${IMAGE_TAG}"
  echo "Container '${CONTAINER_NAME}' has been started."
fi


# コンテナ接続
docker exec -it ${CONTAINER_NAME} bash -l -c "su - sandbox"
