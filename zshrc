source ~/.zplugrc

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


