#!/usr/bin/env bash
DEVELOPMENT_DIR="~/Documents/development"

alias docker-compose-test="docker-compose -f docker-compose.test.yml"
alias mongosh-td="mongosh --port=27052 --username=docker --password=$(get_secret mongocreds docker)"

alias cddotfiles="cd ${DEVELOPMENT_DIR}/dotfilesorsomething"
alias cdsocial="cd ${DEVELOPMENT_DIR}/dots-microservices-social"
alias cdcommon="cd ${DEVELOPMENT_DIR}/dots-microservices-common"
alias cdproto="cd ${DEVELOPMENT_DIR}/protobufs"
