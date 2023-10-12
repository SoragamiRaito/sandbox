#!/bin/bash

# イメージとコンテナの名前を定義
IMAGE_NAME=sandbox_ubuntu_image
CONTAINER_NAME=sandbox_ubuntu

# ホスト側のUIDとGIDを取得
HOST_USER_ID=$(id -u)
HOST_GROUP_ID=$(id -g)

# Dockerイメージをビルド
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  # イメージが存在しない場合、新たにビルド
  docker build --build-arg USER_ID=$HOST_USER_ID --build-arg GROUP_ID=$HOST_GROUP_ID -t $IMAGE_NAME .
else
  # イメージが存在する場合、キャッシュを無効化してビルド
  docker build --build-arg USER_ID=$HOST_USER_ID --build-arg GROUP_ID=$HOST_GROUP_ID --no-cache -t $IMAGE_NAME .
fi

# コンテナの状態を確認し、起動または再開
if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]]; then
  # コンテナが起動していない場合、新たに起動
  docker run -d --name $CONTAINER_NAME $IMAGE_NAME
else
  if [[ "$(docker ps -q -f status=exited -f name=$CONTAINER_NAME)" != "" ]]; then
    # コンテナが停止している場合、再開
    docker start $CONTAINER_NAME
  fi
fi

# コンテナに接続
docker exec -it -u sandbox $CONTAINER_NAME /bin/bash
