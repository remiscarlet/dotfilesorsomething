#!/usr/bin/env bash

# CD aliases
alias cddevelopment="cd ${DEVELOPMENT_DIR}"

if [[ $HWID == "Remi MBA" ]];
then
    alias cdblog="cd ${DEVELOPMENT_DIR}/anerdthat.codes/web/anerdthatcodes"
    alias cdjconj="cd ${DEVELOPMENT_DIR}/JCoNJ"
    alias cdblueleaf="cd ${DEVELOPMENT_DIR}/Blueleaf"
    alias cdoa="cd ${DEVELOPMENT_DIR}/order-of-axis"
fi

if [[ $HWID == "Dots Laptop" ]];
then
    alias cddotfiles="cd ${DEVELOPMENT_DIR}/dotfilesorsomething"
    alias cdsocial="cd ${DEVELOPMENT_DIR}/dots-microservices-social"
    alias cdanalytics="cd ${DEVELOPMENT_DIR}/dots-microservices-analytics"
    alias cdadminclient="cd ${DEVELOPMENT_DIR}/dots-microservices-social/services/admin_client"
    alias cdcommon="cd ${DEVELOPMENT_DIR}/dots-microservices-common"
    alias cdproto="cd ${DEVELOPMENT_DIR}/protobufs"
    alias cdlegacy="cd ${DEVELOPMENT_DIR}/twodots-api"
    alias cdinfra="cd ${DEVELOPMENT_DIR}/dots-infra"
fi

