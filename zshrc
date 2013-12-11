source ~/.antigen.zsh
source ~/.antigenrc

# Platform dependent configs
if [[ `uname` == 'Linux' ]]
then
elif [[ `uname` == 'Darwin' ]]
    # Enable ZSH completion on mac
    fpath=(/usr/local/share/zsh-completions $fpath)

    local ADT_LOCATION="$HOME/development/adt-bundle-mac-x86_64-20131030/sdk/platform-tools"
    if [ -d "$ADT_LOCATION" ]
    then
        # Add android SDK to path if it exists
        path+=("$ADT_LOCATION")
    fi
then
else # Might as well assume Windows here
fi

if [ -d "$HOME/bin" ]
then
    path=($HOME/bin $path)
fi

export PATH

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

