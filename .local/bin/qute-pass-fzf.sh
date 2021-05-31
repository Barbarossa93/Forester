#!/usr/bin/env bash
set -euo pipefail

#read stuff
#[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
input=$(cat)
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" --reverse --border=horizontal --no-info --header=' ' --prompt ' │ ' --pointer '― ' -e"
#termite --name qute-pass -e "bash -c 'echo \"$input\" | fzf'"
urxvtdc -name qute-pass -g 29x16 -e bash -c "echo \"$input\" | fzf" #| tee /tmp/qute-pass"
