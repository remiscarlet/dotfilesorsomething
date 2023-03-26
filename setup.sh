#!/usr/bin/env bash

CWD="$(dirname ${BASH_SOURCE[0]})" 2> /dev/null

if [ -z "$CWD" ]; then
    CWD="${0:a:h}"
fi
CWD=$(readlink -f $CWD)


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
