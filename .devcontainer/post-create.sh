#!/bin/sh

#gitの設定
git config --global user.email "soragamiraito@gmail.com"
git config --global user.name "SoragamiRaito"

# loginshellの変更
sudo chsh -s "$(which zsh)"

# .envの読み込み追加
cp $HOME/workspace/.devcontainer/.env $HOME/.env
echo 'source $HOME/.env' >>~/.bashrc
echo 'source $HOME/.env' >>~/.zshrc

# starshipの導入
echo 'eval "$(starship init bash)"' >>~/.bashrc
echo 'eval "$(starship init zsh)"' >>~/.zshrc
cp $HOME/workspace/.devcontainer/starship.toml ~/.config/starship.toml
curl -sS https://starship.rs/install.sh | sh -s -- -y
