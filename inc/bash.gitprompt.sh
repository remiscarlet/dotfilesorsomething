#!/usr/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/secrets/secrets.sh"

# get the name of the branch we are on and whether or not it's dirty in a fast and not insane way
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo " (${ref#refs/heads/})$(parse_git_dirty)"
}

# Checks if working tree is dirty
parse_git_dirty() {
  local SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
     if [[ -n ${DISABLE_RODEO_WRANGLE} ]]; then
       echo "$GIT_PROMPT_DIRTY"
     fi
  else
    echo "$GIT_PROMPT_CLEAN"
  fi
}

GIT_PROMPT_DIRTY=" x"
GIT_PROMPT_CLEAN=""

if ! command -v hostid &> /dev/null
then
    HOST="MACOS"
else
    HOST=$(get_secret hostids $(hostid))
fi

##############################
# Git Commands
#############################
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
     GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"

  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${RED}⚡ "
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}

function git_dirty_flag {
  git status 2> /dev/null | grep -c : | awk '{if ($1 > 0) print "⚡ "}'
}

function prompt_func() {
    previous_return_value=$?;
    #The lowercase w is the full current working directory
    #prompt="${TITLEBAR}${BLUE}[${RED}\w${GREEN}$(parse_git_branch)${BLUE}]${COLOR_NONE}"

    #Capital W is just the trailing part of the current working directory
    prompt="${RED}[${LIGHT_GRAY}${HOST}${RED}]${TITLEBAR}${BLUE}[${YELLOW}\W${GREEN}$(git_prompt_info)${BLUE}]${COLOR_NONE}"

    # Py VirtualEnv stuff
    if [[ "$VIRTUAL_ENV" != "" ]]
    then
        VENV_NAME=$(basename $VIRTUAL_ENV)
        prompt="${YELLOW}(${WHITE}VENV:${RED}$VENV_NAME${YELLOW})${prompt}"
    fi

    if test $previous_return_value -eq 0
    then
        PS1="${prompt}> "
    else
        PS1="${prompt}${RED}>${COLOR_NONE} "
    fi
}

PROMPT_COMMAND=prompt_func
