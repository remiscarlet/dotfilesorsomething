#!/usr/bin/env bash

CWD="$(dirname ${BASH_SOURCE[0]})" 2> /dev/null

if [ -z "$CWD" ]; then
    CWD="${0:a:h}"
fi
CWD=$(readlink -f $CWD)

# Install stuff

if [[ "$SHELL" != *"zsh" ]]; then
    sudo apt install zsh
    chsh -s /bin/zsh
fi

which pyenv
if [[ "$?" == "1" ]]; then
    curl https://pyenv.run | bash
    sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev curl \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
fi

if [[ x"$INSTALL_DOCKER" == "x" ]]; then
    echo "The INSTALL_DOCKER envvar was set - Installing docker assuming ubuntu"

    # From https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg

    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo apt-get install docker-compose-plugin
fi

# Symlinks

if [[ ! -d "~/.tmux" ]]; then
    ln -s $CWD/.tmux ~/.tmux
fi

if [[ ! -f "~/.tmux.conf" ]]; then
    ln -s $CWD/.tmux.conf ~/.tmux.conf
fi

if [[ ! -d "~/.vim" ]]; then
    ln -s $CWD/.vim ~/.vim
fi

if [[ ! -f "~/.vimrc" ]]; then
    ln -s $CWD/.vimrc ~/.vimrc
fi


if [[ "$SHELL" == *"zsh" && ! -d "~/.zsh" ]]; then
    ln -s $CWD/.zsh ~/.zsh
fi

# All systems
grep ".bash_base" ~/.zshrc
if [[ $? -eq 0 ]];
then
    echo "Your ~/.zshrc already seems to be sourcing .bash_base. Add -f to force install. Aborting. TODO: Implement the flag."
else
    echo "source $CWD/.bash_base" > ~/.zshrc
fi



# Mac
if [[ $(uname -s) == "Darwin" ]];
then
    defaults write com.apple.finder AppleShowAllFiles true;
fi
