#!/usr/bin/env bash
set -euo pipefail

#read stuff
#[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
input=$(cat)
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" --reverse --border=horizontal --no-info --header=' ' --prompt ' │ ' --pointer '― ' -e"
#termite --name qute-pass -e "bash -c 'echo \"$input\" | fzf'"
st -n qute-pass -e bash -c "echo \"$input\" | tac | nl |  fzf | cut -f 2- | tee /tmp/fzf-link"
