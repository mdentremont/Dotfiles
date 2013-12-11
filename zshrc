# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Use a different custom directory
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="girazz"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
#
# NOTE: zsh-syntax-highlighting must come before zsh-history-substring-search
#
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git pip vi-mode vim-mode zsh-syntax-highlighting zsh-history-substring-search)

# Platform dependent configs
if [[ `uname` == 'Linux' ]]
then
    plugins=(command-not-found $plugins)
elif [[ `uname` == 'Darwin' ]]
    # Enable ZSH completion on mac
    fpath=(/usr/local/share/zsh-completions $fpath)

    local ADT_LOCATION="$HOME/development/adt-bundle-mac-x86_64-20131030/sdk/platform-tools"
    if [ -d "$ADT_LOCATION" ]
    then
        # Add android SDK to path if it exists
        path+=("$ADT_LOCATION")
        export PATH
    fi

    plugins=(brew $plugins)
then
else # Might as well assume Windows here
fi

source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases

HISTSIZE=10000
SAVEHIST=10000

# Syntax highlighting configs
#
# Note: Run the following to list configured colours
#     printf '%s => %s\n' ${(kv)ZSH_HIGHLIGHT_STYLES}
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'

# Use Vi key bindings
bindkey -v

# Reduce the timeout on escape sequences
export KEYTIMEOUT=1

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

# zsh-history-substring-search bindings
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
#bindkey "${terminfo[kcuu1]}" history-substring-search-up
#bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

