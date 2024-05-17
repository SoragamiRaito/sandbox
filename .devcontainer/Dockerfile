FROM mcr.microsoft.com/devcontainers/base:ubuntu

USER vscode

COPY share/ /share/

RUN cp /share/.env $HOME/.env && \
    git config --global user.email "soragamiraito@gmail.com" && \
    git config --global user.name "SoragamiRaito" && \
    sudo chsh -s "$(which zsh)" && \
    echo 'source $HOME/.env' >>~/.bashrc && \
    echo 'source $HOME/.env' >>${ZDOTDIR-$HOME}/.zshrc && \
    echo 'eval "$(starship init bash)"' >>~/.bashrc && \
    echo 'eval "$(starship init zsh)"' >>${ZDOTDIR-$HOME}/.zshrc && \
    echo 'eval "$(mise activate bash)"' >>~/.bashrc && \
    echo 'eval "$(mise activate zsh)"' >>${ZDOTDIR-$HOME}/.zshrc && \
    cp /share/starship.toml $HOME/.config/starship.toml && \
    curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    curl https://mise.run | sh
RUN sudo rm -rf /share

CMD ["sleep", "infinity"]
