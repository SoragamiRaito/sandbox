#!/bin/bash

# .env ファイルから PASSWORD 環境変数を読み込む
PASSWORD=$(cat .env | grep PASSWORD= | cut -d '=' -f2)

# Dockerイメージの名前とタグ
IMAGE_NAME="my_ubuntu_image"
IMAGE_TAG="latest"

# Dockerfileのハッシュ値を取得
CURRENT_HASH=$(docker inspect --format='{{.Id}}' .)

# 以前にビルドしたイメージのハッシュ値を取得
PREVIOUS_HASH=$(docker images -q "${IMAGE_NAME}:${IMAGE_TAG}")

# Dockerfileのハッシュ値を比較し、変更があるかを確認
if [ "$CURRENT_HASH" != "$PREVIOUS_HASH" ]; then
  echo "Building Docker image..."
  docker build --build-arg PASSWORD=${PASSWORD} -t "${IMAGE_NAME}:${IMAGE_TAG}" .
else
  echo "Docker image was already built and there are no changes in Dockerfile."
fi

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
docker exec -it soragami_ubuntu /bin/bash