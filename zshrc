source ~/.antigen.zsh
source ~/.antigenrc

# Platform dependent configs
if [[ `uname` == 'Darwin' ]]
then
    # Enable ZSH completion on mac
    fpath=(/usr/local/share/zsh-completions $fpath)

fi

HISTSIZE=10000
SAVEHIST=10000

# Use Vi key bindings
bindkey -v

# Reduce the timeout on escape sequences
export KEYTIMEOUT=1

[ -z $HOST ] && export HOST=`hostname`

# Source all configs
for file in $(find ~/.zsh.d/ -type f | sort)
do
    source $file
done

