#!/usr/bin/env zsh

# Performance measure
# zmodload zsh/zprof

# # Kiro CLI pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

# # Ghostty integration
# if [ "$TERM" = "xterm-ghostty" ]; then
#   source <(ghostty shell-integration)
# fi

# Fix for Homebrew completion security warning
ZSH_DISABLE_COMPFIX=true

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"

# PATH configuration
export PATH="/usr/local/bin:$PATH"

# Homebrew (macOS Apple Silicon)
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export HOMEBREW_CASK_OPTS="--appdir=~/Applications" # set non-admin application folder
fi

# nvm
export NVM_DIR="$HOME/.nvm"
_lazy_nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm() { _lazy_nvm; nvm "$@"; }
node() { _lazy_nvm; node "$@"; }
npm() { _lazy_nvm; npm "$@"; }
npx() { _lazy_nvm; npx "$@"; }

# uv
export PATH="$HOME/.local/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# Java
# if [ -d "/opt/homebrew/opt/openjdk@17" ]; then
#     export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
# fi

# GitLab CLI
export GLAB_DISABLE_TELEMETRY=1
export GLAB_FORCE_HYPERLINKS=1

# Brew 
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# Homebrew (Linux)
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'

# kubectl aliases
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias kns='kubens'
alias c="agy-ide"

# brew install workaround for non-admin mac
alias bcin='brew install --cask --appdir="~/Applications"'

# Modern CLI tools
if command -v bat &> /dev/null; then
    alias cat='bat'
elif command -v batcat &> /dev/null; then
    alias cat='batcat'
fi

if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# Source user-specific extras
if [ -f "$HOME/.extra" ]; then
    source "$HOME/.extra"
fi

# Added by Antigravity
export PATH="/Users/allen.chan/.antigravity/antigravity/bin:$PATH"

# Enhancing Search with fd
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

plugins=(
    alias-finder
    aliases
    aws
    apt
    copybuffer
    copyfile
    docker
    docker-compose
    git
    golang
    helm
    history-substring-search
    kube-ps1
    kubectl
    kubectx
    npm
    python
    sudo
    tldr
    tmux
    ubuntu
    web-search
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    # zsh-fzf-history-search
)

# Anitgen
source $(brew --prefix)/share/antigen/antigen.zsh
# source ~/antigen.zsh

antigen use oh-my-zsh
antigen theme robbyrussell

antigen bundle sudo
antigen bundle copyfile
antigen bundle copybuffer
antigen bundle thefuck
antigen bundle git
antigen bundle brew
antigen bundle alias-finder
antigen bundle docker
antigen bundle kubectl
antigen bundle terraform
antigen bundle joshskidmore/zsh-fzf-history-search
#antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle jonmosco/kube-ps1

antigen apply

# mise must activate after antigen so its shims stay at the front of PATH
eval "$(mise activate zsh)"

# Faster Alternatives: Switch to Antidote (Antigen-compatible, static compilation, 10x faster load).

# ANTIDOTE_CACHE_DIR=~/.antidote
# source $(brew --prefix)/share/antidote/antidote.zsh
# antidote load ~/.zsh_plugins.txt

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/allen.chan/.lmstudio/bin"
# End of LM Studio CLI section


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/allen.chan/.local/share/mise/installs/opentofu/latest/tofu tofu

# Slim directory hook
chpwd() {
    if [[ -f .env ]]; then
    set -a        # Automatically export all variables defined...
    source .env   # ...when reading the .env file
    set +a        # Turn auto-export back off
    fi
}
autoload -U add-zsh-hook; add-zsh-hook chpwd chpwd
[[ -f .env ]] && chpwd # Run once on shell start

# Added by Antigravity IDE
export PATH="/Users/allen.chan/.antigravity-ide/antigravity-ide/bin:$PATH"
alias lab='glab'
export IDE=agy-ide
export VISUAL=agy-ide
export EDITOR=nvim

# # Kiro CLI post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
#
# [[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Performance measure
# zprof
