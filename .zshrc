#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#POWERLEVEL9K_STATUS_VERBOSE="true"
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S %m/%d/%Y}"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time time)


# oracle proxy crap
export https_proxy=http://rmdc-proxy.oracle.com:80
export ftp_proxy=http://rmdc-proxy.oracle.com:80
export HTTP_PROXY=http://rmdc-proxy.oracle.com:80
export HTTPS_PROXY=http://rmdc-proxy.oracle.com:80
export FTP_PROXY=http://rmdc-proxy.oracle.com:80
export no_proxy="192.168.0.101, localhost, 127.0.0.1, 0.0.0.0, kernel.us.oracle.com,uln-internal.oracle.com"
export NO_PROXY="192.168.0.101, localhost, 127.0.0.1, 0.0.0.0"

function setProxy() {
  export https_proxy=http://rmdc-proxy.oracle.com:80
  export ftp_proxy=http://rmdc-proxy.oracle.com:80
  export HTTP_PROXY=http://rmdc-proxy.oracle.com:80
  export HTTPS_PROXY=http://rmdc-proxy.oracle.com:80
  export FTP_PROXY=http://rmdc-proxy.oracle.com:80
  export no_proxy="192.168.0.101, localhost, 127.0.0.1, 0.0.0.0, kernel.us.oracle.com,uln-internal.oracle.com"
  export NO_PROXY="192.168.0.101, localhost, 127.0.0.1, 0.0.0.0"
}

function unsetProxy() {
   http_proxy=''
   https_proxy=''
   ftp_proxy=''
   HTTP_PROXY=''
   HTTPS_PROXY=''
   FTP_PROXY=''
}

# vi key binding
set -o vi

# had to add the bindkey for ctrl-r because the abovie vi key binding screwed things up
bindkey '^R' history-incremental-search-backward

# docker autocomplete
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

alias vim=nvim
alias vi=vim

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
#export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='ag -g ""'

#nvm
#export NVM_DIR="$HOME/.nvm"
#  . "/usr/local/opt/nvm/nvm.sh"


# golang
#export GOPATH=$HOME/git/development/golang
#export PATH=$PATH:$GOPATH/bin
#export PATH=$PATH:$(go env GOPATH)/bin
