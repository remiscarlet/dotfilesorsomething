#!/usr/bin/env bash

# TODO: Something about these ssh keys? Should probably just spend a day cleaning them up in general.

# SSH me bby
alias musashi="ssh remi_scarlet@$(get_secret hosts musashi) -p26 -i~/.ssh/DONTLOSETHISASECONDTIMEYOUFUCKTARD.pem"
alias jconj="ssh ubuntu@$(get_secret hosts jconj) -p 22 -i ~/.ssh/YutoMBP.pem"
alias aws="ssh ubuntu@$(get_secret hosts aws) -p 22 -i ~/.ssh/scarletjaeger-aws.pem"
alias anerdthatcodes="ssh ubuntu@$(get_secret hosts antc) -p 22 -i ~/.ssh/scarletjaeger-aws.pem"
alias sachiko="ssh pi@$(get_secret hosts sachiko) -p2222 -i ~/.ssh/DONTLOSETHISASECONDTIMEYOUFUCKTARD.pem"
alias yc="ssh minecraft@$(get_secret hosts ycmc) -p2222 -i ~/.ssh/id_rsa"
alias ycforums="ssh ubuntu@$(get_secret hosts ycforums) -p22 -i ~/.ssh/yc-forums-scarletjaeger.pem"
alias gcp_vm="ssh remi@$(get_secret hosts gcpvm)"

## SSH me bby - LAN Edition
alias cirno="ssh cirno@$(get_secret hosts-lan cirno) -p2224 -i ~/.ssh/DONTLOSETHISASECONDTIMEYOUFUCKTARD.pem"
alias satori="ssh satori@$(get_secret hosts-lan satori) -p2223 -i ~/.ssh/DONTLOSETHISASECONDTIMEYOUFUCKTARD.pem"
