#!/usr/bin/env bash

##########
# Config #
##########

SECRETS_DIR="secrets" # Dir name that contains the lookup array definition files

#
SECRETS_LOADED=1

S_CWD="$(dirname ${BASH_SOURCE[0]})" 2> /dev/null
if [ -z "$S_CWD" ]; then
    S_CWD="${0:a:h}"
fi

SCRIPT_DIR="$( cd -- "$S_CWD" &> /dev/null && pwd )"
S_LOOKUP_TABLE_DIR="${SCRIPT_DIR}/${SECRETS_DIR}/"

function print_arr {
    (IFS=,; echo "$@")
}

function load_secrets {
    S_TABLES=($(find $S_LOOKUP_TABLE_DIR -maxdepth 1 -mindepth 1 -type f | xargs -L1 -I% bash -c "basename %"))
}
load_secrets

function get_secret {
    if [[ ! -f "${S_LOOKUP_TABLE_DIR}${1}" ]]; then
        echo "'$1' was not a valid secrets lookup table!"
        echo "Must be one of: $(print_arr ${S_TABLES[*]})"
        return 1
    fi

    (
    source ${S_LOOKUP_TABLE_DIR}${1}
    if [[ -v map[$2] ]]; then
        echo -n ${map[$2]}
    else
        echo "'$2' was not a valid key in the '$1' secrets lookup table!"
        return 1
    fi
    )
}

if [[ "$SHELL" == *"zsh" ]]; then
    SHELL_CONFIG="$(get_secret homedirs $(get_hwid))/.zshrc"
else
    SHELL_CONFIG="$(get_secret homedirs $(get_hwid))/.bashrc"
fi

function reload_secrets {
    unset SECRETS_LOADED
    load_secrets
    source ${SHELL_CONFIG}
}
alias reload_shell=reload_secrets
