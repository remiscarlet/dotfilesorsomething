#!/usr/bin/env bash

# CD aliases
alias cddevelopment="cd ${DEVELOPMENT_DIR}"

if [[ $HWID == "Remi MBA" ]];
then
    alias cdblog="cd ${DEVELOPMENT_DIR}/anerdthat.codes/web/anerdthatcodes"
    alias cdjconj="cd ${DEVELOPMENT_DIR}/JCoNJ"
    alias cdblueleaf="cd ${DEVELOPMENT_DIR}/Blueleaf"
fi

if [[ $HWID == "Dots Laptop" ]];
then
    alias cddotfiles="cd ${DEVELOPMENT_DIR}/dotfilesorsomething"
    alias cdsocial="cd ${DEVELOPMENT_DIR}/dots-microservices-social"
    alias cdcommon="cd ${DEVELOPMENT_DIR}/dots-microservices-common"
    alias cdproto="cd ${DEVELOPMENT_DIR}/protobufs"
fi

