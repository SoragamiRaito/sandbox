#!/bin/bash

# .env ファイルから PASSWORD 環境変数を読み込む
PASSWORD=$(cat .env | grep PASSWORD= | cut -d '=' -f2)

# Dockerイメージをビルドするコマンド
docker build --build-arg PASSWORD=${PASSWORD} -t my_ubuntu_image .

# スクリプトの終了
exit 0
