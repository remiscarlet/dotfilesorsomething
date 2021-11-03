#!/usr/bin/env bash

#############################
# Host Identification Funcs #
#############################

function get_mac_hwid {
    ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { split($0, line, "\""); printf("%s\n", line[4]); }'
}
function get_linux_hwid {
    hostid
}

function get_hw_type {
    if [[ $(uname -s) == "Darwin" ]];
    then
        echo "mac"
    else
        echo "linux"
    fi
}

function get_hwid {
    if [[ $(get_hw_type) == "mac" ]];
    then
        get_mac_hwid
    else
        get_linux_hwid
    fi
}

##############
# Formatting #
##############

function jqlint {
    cat $1 | jq '.' > tmp.json;
    if [ -s tmp.json ]
    then
        echo "Success"
        mv tmp.json $1
    else
        echo "Failed. Aborted."
        rm tmp.json
    fi
}

#############
# Git Stuff #
#############

function gitsubmoduleupdate {
    git submodule update --init --recursive --remote
}

function cdgits {
    (cd $@ && gits)
}

function cdgitshow {
    (cd $@ && git show)
}

##############
# Docker :-/ #
##############
function dockernetworkinspect {
    docker network inspect dots-microservices-social_default | grep -C 5 $@
}

########
# Misc #
########

function vimdotconfig {
    vim ${DEVELOPMENT_DIR}dotfilesorsomething/$@
}

function debuglog {
    [[ $DEBUG -gt 0 ]] && echo $@
}

function beep {
    echo -en "\007"
}
