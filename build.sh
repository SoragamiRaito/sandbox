#!/bin/bash

# Dockerイメージの名前とタグ
IMAGE_NAME="sandbox_ubuntu_image"
IMAGE_TAG="latest"

# UIDとGITの取得
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# イメージのビルド
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" --build-arg USER_ID=${USER_ID} --build-arg GROUP_ID=${GROUP_ID} .
