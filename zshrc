[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

source ~/.zgenomrc

# Reduce the timeout on escape sequences
export KEYTIMEOUT=1

# Source all configs
#
configs=$(find ~/.zsh.d/ -type f)
configs=$(echo $configs | sort)

configs=$( echo $configs | tr '\n' ' ')

for file in $=configs
do
    source $file
done
