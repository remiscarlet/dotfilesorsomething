#!/usr/bin/env bash

CWD="$(dirname ${BASH_SOURCE[0]})"
# All systems
grep ".bash_base" ~/.bashrc
if [[ $? -eq 0 ]];
then
    echo "Your ~/.bashrc already seems to be sourcing .bash_base. Add -f to force install. Aborting. TODO: Implement the flag."
fi

echo "source $CWD/.bash_base" > ~/.bashrc

# Mac
if [[ $(uname -s) == "Darwin" ]];
then
    defaults write com.apple.finder AppleShowAllFiles true;
fi

