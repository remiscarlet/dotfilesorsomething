#!/usr/bin/env bash

# Should contain general aliases for common commands

if [[ $HWTYPE == "mac" ]];
then
    alias ls="ls -GFal"
else
    alias ls="ls -Fal --color"
fi

alias gits="git status"
alias grep="grep --color"

# Docker
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_images_force='docker rmi -f $(docker images -aq)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias docker_kill_all='docker kill $(docker ps -q)'

if [[ $HWID == "Remi MBA" ]];
then
    alias flush="mv db.sqlite3 backups/db.sqlite3.#{date} && cp db.sqlite3.cleanslate.10.13.17 db.sqlite3"
    alias runserver="python manage.py runserver"
    alias ocaml='rlwrap ocaml'
    alias downloadproddb="scp -P 22 -i ~/.ssh/YutoMBP.pem ubuntu@$(get_secret hosts jconj):/home/ubuntu/web/www.japancenterNJ.com/prod/JCoNJ-web/web/db.sqlite3 ."
    alias flushdns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"

    # Order Of Axis
    alias cdoa="cd /Users/ytakamoto/Dropbox/YutoProgramming/order-of-axis"
    export GOOGLE_CLOUD_KEYFILE_JSON="/Users/ytakamoto/.terraform.d/OA-web-prod-2e39d778420f.json"
fi

if [[ $HWID == "Dots Laptop" ]];
then
    alias docker-compose-test="docker-compose -f docker-compose.test.yml"
    alias mongosh-td="mongosh --port=27052 --username=docker --password=$(get_secret mongocreds docker)"
    alias k9s="k9s --kubeconfig=/tmp/kubeconfig-dev"
    alias psql-td="psql --port=5432 --host=localhost --user=docker"

    alias assumeAwsMasterRole="switchawsprofile devmaster && assumeAwsRole dots_dev_test_admin"
fi
