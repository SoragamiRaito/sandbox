#!/bin/sh

#gitの設定
git config --global user.email "soragamiraito@gmail.com"
git config --global user.name "SoragamiRaito"

# loginshellの変更
sudo chsh -s "$(which zsh)"

# .envの読み込み追加
cp /share/.env $HOME/.env
# bash用
echo 'source $HOME/.env' >>~/.bashrc
# zsh用
echo 'source $HOME/.env' >>~/.zshrc

# starshipの導入
echo 'eval "$(starship init bash)"' >>~/.bashrc
echo 'eval "$(starship init zsh)"' >>~/.zshrc
cp /share/starship.toml $HOME/.config/starship.toml
curl -sS https://starship.rs/install.sh | sh -s -- -y

# miseの導入
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >>~/.bashrc
echo 'eval "$(~/.local/bin/mise activate zsh)"' >>~/.zshrc
