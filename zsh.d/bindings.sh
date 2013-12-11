# Use Alt+. to insert arguments from previous commands
bindkey '\e.' insert-last-word

# Use Alt+m to cycle the arguments from the previous command
#
# Use this in conjunction with Alt+.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

# Enable zmv
autoload -Uz zmv

# Use Ctrl+R to perform a history search for previous commands
bindkey ^R history-incremental-search-backward

