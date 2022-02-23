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

function __unsetawsprofile {
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
}

function __setawsprofile {
    __unsetawsprofile

    if [[ -z "$1" || -z "$2" ]]; then
        echo "Must provide two arguments to setawsprofile! Got: '$1' and '$2'. Aborting."
        (exit 1)
    fi

    export AWS_ACCESS_KEY_ID=$1
    export AWS_SECRET_ACCESS_KEY=$2
    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    echo "Successfully changed aws creds to '$1:$2' for [default] aws profile"
}

function initaws {
    switchawsprofile devmaster
}

function switchawsprofile {
    __unsetawsprofile

    CREDSTRING=$(get_secret awscreds $1)
    if [[ $? -ne 0 ]]; then
        echo -e "Gave an invalid credential id. Got: $1.\nAborting."
        (exit 1)
    fi

    read -r AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY <<< $(IFS=':' read -ra SPLIT <<< "$CREDSTRING"; echo "${SPLIT[@]}")

    __setawsprofile $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
}

function assumeAwsRole {
    __unsetawsprofile

    ROLE_ARN=$(get_secret aws_role_arn $1)
    echo "ROLE_ARN: $ROLE_ARN"
    OUT=$(aws sts assume-role  --role-arn $ROLE_ARN --role-session-name "ytakamoto-temp")

    echo "OUT: $OUT"

    if [[ -z "$(echo $OUT | jq .AssumedRoleUser)" ]]; then
        echo "Could not successfully invoke 'aws sts assume-role'!"
        echo "Got:\n$OUT"
        (exit 1)
    fi

    __setawsprofile $(echo $OUT | jq -r .Credentials.AccessKeyId) $(echo $OUT | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo $OUT | jq -r .Credentials.SessionToken)
    echo "Set AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN"
}

function ecrdockerlogin {
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(get_secret aws_ecr_registries dots_dev_test_admin)
}

function awswhoami {
    aws sts get-caller-identity
}

function awsprintenv {
    echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
    echo "AWS_CA_BUNDLE: $AWS_CA_BUNDLE"
    echo "AWS_CLI_AUTO_PROMPT: $AWS_CLI_AUTO_PROMPT"
    echo "AWS_CLI_FILE_ENCODING: $AWS_CLI_FILE_ENCODING"
    echo "AWS_CONFIG_FILE: $AWS_CONFIG_FILE"
    echo "AWS_DEFAULT_OUTPUT: $AWS_DEFAULT_OUTPUT"
    echo "AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION"
    echo "AWS_EC2_METADATA_DISABLED: $AWS_EC2_METADATA_DISABLED"
    echo "AWS_MAX_ATTEMPTS: $AWS_MAX_ATTEMPTS"
    echo "AWS_PAGER: $AWS_PAGER"
    echo "AWS_PROFILE: $AWS_PROFILE"
    echo "AWS_REGION: $AWS_REGION"
    echo "AWS_RETRY_MODE: $AWS_RETRY_MODE"
    echo "AWS_ROLE_ARN: $AWS_ROLE_ARN"
    echo "AWS_ROLE_SESSION_NAME: $AWS_ROLE_SESSION_NAME"
    echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
    echo "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"
    echo "AWS_SHARED_CREDENTIALS_FILE: $AWS_SHARED_CREDENTIALS_FILE"
    echo "AWS_STS_REGIONAL_ENDPOINTS: $AWS_STS_REGIONAL_ENDPOINTS"
    echo "AWS_WEB_IDENTITY_TOKEN_FILE: $AWS_WEB_IDENTITY_TOKEN_FILE"
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
