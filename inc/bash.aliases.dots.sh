#!/usr/bin/env bash

alias docker-compose-test="docker-compose -f docker-compose.test.yml"
alias mongosh-td="mongosh --port=27052 --username=docker --password=$(get_secret mongocreds docker)"
