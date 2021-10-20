#!/usr/bin/env bash

# Should contain general aliases for common commands

alias ls="ls -GFal"

if [[ $HWID == "Remi MBA" ]];
then
    alias flush="mv db.sqlite3 backups/db.sqlite3.#{date} && cp db.sqlite3.cleanslate.10.13.17 db.sqlite3"
    alias runserver="python manage.py runserver"
    alias ocaml='rlwrap ocaml'
    alias gits="git status"
    alias downloadproddb="scp -P 22 -i ~/.ssh/YutoMBP.pem ubuntu@$(get_secret hosts jconj):/home/ubuntu/web/www.japancenterNJ.com/prod/JCoNJ-web/web/db.sqlite3 ."
    alias flushdns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"

    # Order Of Axis
    alias cdoa="cd /Users/ytakamoto/Dropbox/YutoProgramming/order-of-axis"
    export GOOGLE_CLOUD_KEYFILE_JSON="/Users/ytakamoto/.terraform.d/OA-web-prod-2e39d778420f.json"
fi

if [[ $HWID == "Dots Laptop" ]];
then
    alias grep="grep --color"

    alias docker-compose-test="docker-compose -f docker-compose.test.yml"
    alias mongosh-td="mongosh --port=27052 --username=docker --password=$(get_secret mongocreds docker)"

    alias cddotfiles="cd ${DEVELOPMENT_DIR}/dotfilesorsomething"
    alias cdsocial="cd ${DEVELOPMENT_DIR}/dots-microservices-social"
    alias cdcommon="cd ${DEVELOPMENT_DIR}/dots-microservices-common"
    alias cdproto="cd ${DEVELOPMENT_DIR}/protobufs"
fi
