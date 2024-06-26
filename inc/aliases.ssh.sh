#!/usr/bin/env bash

# TODO: Something about these ssh keys? Should probably just spend a day cleaning them up in general.

# SSH me bby
alias musashi="ssh remi_scarlet@$(get_secret hosts musashi) -p26 -i~/.ssh/DONTLOSETHISASECONDTIMEYOUFUCKTARD.pem"
alias jconj="ssh ubuntu@$(get_secret hosts jconj) -p 22 -i ~/.ssh/YutoMBP.pem"
alias aws_scarletjaeger="ssh ubuntu@$(get_secret hosts aws) -p 22 -i ~/.ssh/scarletjaeger-aws.pem"
alias anerdthatcodes="ssh ubuntu@$(get_secret hosts antc) -p 22 -i ~/.ssh/scarletjaeger-aws.pem"
alias sachiko="ssh pi@$(get_secret hosts sachiko) -p2222 -i ~/.ssh/DONTLOSETHISASECONDTIMEYOUFUCKTARD.pem"
alias yc="ssh minecraft@$(get_secret hosts ycmc) -p2222 -i ~/.ssh/id_rsa"
alias ycremi="ssh remi@$(get_secret hosts ycmc) -p2222 -i ~/.ssh/id_rsa"
alias ycforums="ssh ubuntu@$(get_secret hosts ycforums) -p22 -i ~/.ssh/yc-forums-scarletjaeger.pem"
alias gcp_vm="ssh remi@$(get_secret hosts gcpvm)"

alias cloud_desk="ssh $(get_secret hosts amazon-cloud-desktop)"
alias cloud_desk2="ssh $(get_secret hosts amazon-cloud-desktop-mkii)"
alias cloud_desk3="ssh $(get_secret hosts amazon-cloud-desktop-mkiii)"

## SSH me bby - LAN Edition
alias cirno="ssh cirno@$(get_secret hosts-lan cirno) -p2224 -i ~/.ssh/id_rsa"
alias satori="ssh satori@$(get_secret hosts-lan satori) -p2223 -i ~/.ssh/DONTLOSETHISASECONDTIMEYOUFUCKTARD.pem"

