#!/bin/bash

# Dockerイメージの名前とタグ
IMAGE_NAME="sandbox_ubuntu_image"
IMAGE_TAG="latest"

# イメージのビルド
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .