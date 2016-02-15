source ~/.zplugrc

HISTSIZE=10000
SAVEHIST=10000

# Reduce the timeout on escape sequences
export KEYTIMEOUT=1

# Source all configs
for file in $(find ~/.zsh.d/ -type f | sort)
do
    source $file
done


