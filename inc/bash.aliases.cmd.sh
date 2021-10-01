#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/secrets/secrets.sh"

# Commands
alias flush="mv db.sqlite3 backups/db.sqlite3.#{date} && cp db.sqlite3.cleanslate.10.13.17 db.sqlite3"
alias runserver="python manage.py runserver"
alias ocaml='rlwrap ocaml'
alias gits="git status"
alias downloadproddb="scp -P 22 -i ~/.ssh/YutoMBP.pem ubuntu@$(get_secret hosts jconj):/home/ubuntu/web/www.japancenterNJ.com/prod/JCoNJ-web/web/db.sqlite3 ."
alias flushdns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
