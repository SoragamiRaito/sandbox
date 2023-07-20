#!/bin/bash

# Dockerイメージの名前とタグ
IMAGE_NAME="sandbox_ubuntu_image"
IMAGE_TAG="latest"

# コンテナの名前
CONTAINER_NAME="sandbox_ubuntu"

# コンテナが既に起動しているかを確認
if docker ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
  echo "Container '${CONTAINER_NAME}' is already running."
else
  # コンテナを起動
  docker run -d --name "${CONTAINER_NAME}" "${IMAGE_NAME}:${IMAGE_TAG}"
  echo "Container '${CONTAINER_NAME}' has been started."
fi

# コンテナ接続
docker exec -it -u sandbox ${CONTAINER_NAME} bash -c "cd ~ && bash"