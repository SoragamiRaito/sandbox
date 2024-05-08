#!/bin/sh

#gitの設定
git config --global user.email "soragamiraito@gmail.com"
git config --global user.name "SoragamiRaito"

# loginshellの変更
sudo chsh -s $(which zsh)

# starshipの導入
echo 'eval "$(starship init bash)"' >>~/.bashrc
echo 'eval "$(starship init zsh)"' >>~/.zshrc
cp /home/workspace/.devcontainer/starship.toml ~/.config/starship.toml
curl -sS https://starship.rs/install.sh | sh -s -- -y
