HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks

# zsh auto compinit
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# nodenv
eval "$(nodenv init - --no-rehash)"

export PATH="/usr/local/sbin:$PATH"

# Docker & k8s
source <(kubectl completion zsh)
source <(argocd completion zsh)
export DOCKER_CONTENT_TRUST=1
export KUBECONFIG=$HOME/.kube/config

# alias
alias ll="ls -ltra"
alias bat="bat --style='numbers,grid' --theme GitHub"
alias g='git'
alias globalip="curl inet-ip.info"
alias find="gfind"

# starship: https://starship.rs/ja-jp/
eval "$(starship init zsh)"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Docker & Kubernetes
alias d="docker"
alias k="kubectl"

# change directory
function peco-src () {
  local selected_dir
  selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

zle -N peco-src
bindkey '^]' peco-src

# history print
function peco-history() {
  local tac
  if type tac &> /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval "$tac" | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}

zle -N peco-history
bindkey '^r' peco-history

# checkout branch
function peco-branch() {
  local selected_branch
  selected_branch="$(g for | grep -v 'origin' | peco | head -n 1 | awk '{ print $2 }')"
  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    CURSOR=$#BUFFER
  fi
}
zle -N peco-branch
bindkey '^b' peco-branch
