#!/usr/bin/env bash

#############################
# Host Identification Funcs #
#############################

function get_mac_hwid {
    ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { split($0, line, "\""); printf("%s\n", line[4]); }'
}
function get_linux_hwid {
    hostid
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

########
# Misc #
########

function debuglog {
    [[ $DEBUG -gt 0 ]] && echo $@
}

function beep {
    echo -en "\007"
}
