#!/bin/bash

# Dockerイメージの名前とタグ
IMAGE_NAME="my_ubuntu_image"
IMAGE_TAG="latest"

# イメージのビルド
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .

# コンテナの名前
CONTAINER_NAME="soragami_ubuntu"

# コンテナが既に起動しているかを確認
if docker ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
  echo "Container '${CONTAINER_NAME}' is already running."
else
  # コンテナを起動
  docker run -d --name "${CONTAINER_NAME}" "${IMAGE_NAME}:${IMAGE_TAG}"
  echo "Container '${CONTAINER_NAME}' has been started."
fi

# コンテナ接続
docker exec -it -u soragami ${CONTAINER_NAME} /bin/bash