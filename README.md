# sandbox

砂場。  
なんとなくお試しでいろいろやって見る場所。
ちゃんとdocker使っていきたいとは思っている。

## 使い方

- イメージのビルド

    `./build.sh`

- コンテナを起動して接続

    `./up.sh`

## dockerコマンドチートシート

- コンテナ起動

    `docker run -d --name "sandbox_ubuntu" sandbox_ubuntu_image`

- コンテナに接続

    `docker exec -it -u sandbox sandbox_ubuntu bash -c "cd ~ && bash"`

- コンテナ終了

    `docker stop sandbox_ubuntu`
