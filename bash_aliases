# Bash aliases
alias ls='ls --color'
alias o='open "$@"'
alias scasutils='$GIT_HOME/search-cs/misc/scasutils.sh'
alias enable_dev_mode='$GIT_HOME/search-cs/misc/scasutils.sh enable_dev_mode'
alias rm_search='$GIT_HOME/search-cs/misc/scasutils.sh rm_search'
alias bdt='bdt.py'
alias bdt-ssh='bdt -CLI -r "SSH" --rtasUser="mdentremont" --rtasPassword='"'"'%X!Sntn6jb'"'"

function gv { ( gvim -f "$@" & ) &>/dev/null ; }
complete -r gv 

# Git aliases
alias g="git"
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

alias gb="git b"
complete -o bashdefault -o default -o nospace -F __git_branch gb

alias gd="git diff"
complete -o bashdefault -o default -o nospace -F __git_diff gd

alias gdc="git diff --cached"
complete -o bashdefault -o default -o nospace -F __git_diff gdc

alias gg="git gui&"

alias gl="git l"
complete -o bashdefault -o default -o nospace -F __git_log gl

alias glp="git lp"
complete -o bashdefault -o default -o nospace -F __git_log glp

alias gs="git status"
complete -o bashdefault -o default -o nospace -F __git_status gs

gmod () {
    path=$(git rev-parse --show-toplevel || pwd)
    [[ -z "$1" ]] && files="$(cd $path ; git status --porcelain | sed 's/^ *[^ ]* *//' | sort -u)"
    [[ -z $files ]] && files="$(cd $path; git diff-tree --no-commit-id --name-only -r ${1:-HEAD})"
    files=$(echo "$files" | sed "s!^!$path/!" | grep -v '/images/' | while read line ; do file "$line" | grep -q '\btext\b' && echo $line ; done)
    g $(echo "$files" | xargs echo)
}
