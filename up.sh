#!/bin/bash

# イメージとコンテナの名前を定義
IMAGE_NAME=sandbox_ubuntu_image
CONTAINER_NAME=sandbox_ubuntu
BACK="no"
BUILD="no"

while getopts "i:c:v:b:r" opt; do
  case $opt in
  i)
    IMAGE_NAME="$OPTARG"
    ;;
  c)
    CONTAINER_NAME="$OPTARG"
    ;;
    # コンテナ内にworkspaceディレクトリをバインドするようにする。イメージのビルドやコンテナの起動関数も変更する。
  v)
    VIND="$OPTARG"
    ;;
  b)
    BACK="yes"
    ;;
  r)
    BUILD="yes"
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

# イメージが見つからない場合ビルドフラグを変更
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
  echo "Can not fined '$IMAGE_NAME'. Building image..."
  BUILD="yes"
fi

# ビルド
if [[ "$BUILD" == "yes" ]]; then
  docker build --build-arg USER_ID="$HOST_USER_ID" --build-arg GROUP_ID="$HOST_GROUP_ID" -t "$IMAGE_NAME" .
  if [ $? -eq 0 ]; then
    echo "image '$IMAGE_NAME' is built."
  else
    echo "failed building image."
    exit 1
  fi
fi

# コンテナの状態を確認し、起動または再開
if [[ "$(docker ps -a -q -f name="$CONTAINER_NAME")" == "" ]]; then
  # コンテナが起動していない場合、新たに起動
  if [[ -n "$VIND" ]]; then
    # -vオプションが指定されている場合
    docker run -v "$VIND" -d --name "$CONTAINER_NAME" "$IMAGE_NAME"
  else
    # -vオプションが指定されていない場合
    docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME"
  fi
elif [[ "$(docker ps -a -a -q -f status=exited -f name="^$CONTAINER_NAME\$")" != "" ]]; then
  # コンテナが停止している場合、再開
  docker start "$CONTAINER_NAME"
fi

# -bオプションが指定されていない場合のみコンテナに接続し、コンテナ内でcdコマンドを実行
if [[ "$BACK" == "no" ]]; then
  docker exec -it -u sandbox "$CONTAINER_NAME" /bin/bash -c "cd ~ && /bin/bash"
fi
