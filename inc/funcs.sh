#!/usr/bin/env bash

#############################
# Host Identification Funcs #
#############################

function get_mac_hwid {
    ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { split($0, line, "\""); printf("%s\n", line[4]); }'
}

function get_linux_hwid {
    echo "$(cat /etc/machine-id)-$(whoami)"
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

function mygrep {
    grep -rI --exclude-dir=".git" --exclude-dir="node_modules" --exclude-dir=".mypy_cache" "$@"
}

##############
# Docker :-/ #
##############

function dockernetworkinspect {
    docker network inspect dots-microservices-social_default | grep -C 5 $@
}

function dockerexecit {
docker exec -it dots-microservices-social_${@}_1 /bin/bash
}
function dockerexecitintegrations {
docker exec -it tests_integration_${@}_1 /bin/bash
}

#######
# AWS #
#######

function switchawsprofile {
    CREDSTRING=$(get_secret awscreds $1)
    if [[ $? -ne 0 ]]; then
        echo -e "Gave an invalid credential id. Got: $1.\nAborting."
        return 1
    fi

    read -r AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY <<< $(IFS=':' read -ra SPLIT <<< "$CREDSTRING"; echo "${SPLIT[@]}")
    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    export AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY
    echo "Successfully changed aws creds to '$1' for [default] aws profile"
}

#######
# K8s #
#######

KUBECONFIG=/tmp/kubeconfig-dev
function k9s-docker {
    docker run --rm -it -v $KUBECONFIG:/root/.kube/config quay.io/derailed/k9s
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
