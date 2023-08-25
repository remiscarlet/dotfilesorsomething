#!/usr/bin/env bash

# Any "has to come last" type things for cli/env setup

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [[ $HWTYPE == "mac" ]];
then
    # Make GNU grep available
    export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

    # Node export
    # What about linux? Diff paths? Same?
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

if [[ $HWID == "AGS-CloudDesk" ]];
then
    export PATH="/apollo/env/envImprovement/bin:$PATH"
fi

if [[ $HWID == "AGS" ]];
then
    export PATH="$HOME/.toolbox/bin:$PATH"
fi

# Pyenv - I think all setups can use these fine?
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# psql
export PATH="/usr/local/opt/libpq/bin:$PATH"

# Terminal Styling
# Should come after gitprompt
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
