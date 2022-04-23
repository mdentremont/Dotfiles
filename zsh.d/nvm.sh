if [[ ! -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
  return
fi

# From https://stackoverflow.com/a/47017363
lazynvm() {
  unset -f nvm node npm

  export NVM_HOMEBREW=/opt/homebrew/opt/nvm
  export NVM_DIR="$HOME/.nvm"
  . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  unalias nvim
}

nvm() {
  lazynvm 
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

# coc needs node
alias nvim='typeset -f lazynvm >/dev/null && lazynvm; nvim'
