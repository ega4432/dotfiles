HISTTIMEFORMAT='%Y-%m-%dT%T%z '

alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias sl='ls'
alias ll='ls -ltra'

alias mv='mv -i'
alias cp='cp -i'
alias c='clear'
alias grep="grep --color"
alias globalip="curl https://inet-ip.info"

# Git
alias g="git"
alias ga="git a"
alias gs="git s"

# Goland
alias goland="/usr/local/bin/goland"

# Starship on bash prompt ( https://starship.rs/ )
eval "$(starship init bash)"

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
. <(asdf completion bash)

