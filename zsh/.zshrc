#!/usr/bin/env zsh

# Performance measure
zmodload zsh/zprof

# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"


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

# PATH configuration
export PATH="/usr/local/bin:$PATH"

# Homebrew (macOS Apple Silicon)
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# uv
export PATH="$HOME/.local/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# Java
# if [ -d "/opt/homebrew/opt/openjdk@17" ]; then
#     export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
# fi

# Brew 
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

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

alias c="antigravity"
eval $(thefuck --alias f)

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


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Performance measure
zprof

# Faster Alternatives: Switch to Antidote (Antigen-compatible, static compilation, 10x faster load).

# ANTIDOTE_CACHE_DIR=~/.antidote
# source $(brew --prefix)/share/antidote/antidote.zsh
# antidote load ~/.zsh_plugins.txt
