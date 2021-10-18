#!/usr/bin/bash

function beep {
    echo -en "\007"
}

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

