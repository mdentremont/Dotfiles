# zsh-history-substring-search bindings
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

