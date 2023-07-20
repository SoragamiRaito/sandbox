# sandbox

砂場。  
なんとなくお試しでいろいろやって見る場所。
ちゃんとdocker使っていきたいとは思っている。

## dockerコマンドチートシート

- コンテナ起動

`docker run -d --name "my_ubuntu_container" my_ubuntu_image`

- コンテナに接続

`docker exec -it soragami_ubuntu`

- コンテナ終了

`docker stop soragami_ubuntu`
