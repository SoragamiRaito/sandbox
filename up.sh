#!/bin/bash

# イメージとコンテナの名前を定義
IMAGE_NAME=sandbox_ubuntu_image
CONTAINER_NAME=sandbox_ubuntu

while getopts "i:c:" opt; do
  case $opt in
    i)
      IMAGE_NAME="$OPTARG"
      ;;
    c)
      CONTAINER_NAME="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# ホスト側のUIDとGIDを取得
HOST_USER_ID=$(id -u)
HOST_GROUP_ID=$(id -g)

# イメージが存在しない場合、またはDockerfileに変更がある場合、新たにビルド
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" || Dockerfile -nt .dockerimage ]]; then
  docker build --build-arg USER_ID=$HOST_USER_ID --build-arg GROUP_ID=$HOST_GROUP_ID -t $IMAGE_NAME .
  touch .dockerimage
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

# コンテナに接続し、コンテナ内でcdコマンドを実行
docker exec -it -u sandbox $CONTAINER_NAME /bin/bash -c "cd ~ && /bin/bash"
