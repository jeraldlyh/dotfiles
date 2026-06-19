export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
RPROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}]%{$reset_color%}'

path_prepend() {
  local dir="$1"

  [[ -z "$dir" ]] && return 0
  [[ ! -d "$dir" ]] && return 0
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="$dir:$PATH" ;;
  esac
}

# Path
export HOMEBREW_DIR="/opt/homebrew/bin"
export VSCODE_DIR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export MVN_DIR="/opt/apache-maven-3.8.6/bin"
export NVM_DIR="$HOME/.nvm"
export TEX_DIR="/Library/TeX/texbin"
export LOCAL_BIN_DIR="$HOME/.local/bin"
export DOTFILE_DIR="$HOME/dotfiles/scripts"
export OPT_DIR="/opt"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export PNPM_HOME="$HOME/Library/pnpm"

path_prepend "$HOMEBREW_DIR"
path_prepend "$MVN_DIR"
path_prepend "$TEX_DIR"
path_prepend "$VSCODE_DIR"
path_prepend "$LOCAL_BIN_DIR"
path_prepend "$DOTFILE_DIR"
path_prepend "$OPT_DIR"
path_prepend "$PNPM_HOME"

# nvm
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh"
elif [[ -s "$(brew --prefix nvm)/nvm.sh" ]]; then
  . $(brew --prefix nvm)/nvm.sh
fi

# pyenv 
 export PYENV_ROOT="$HOME/.pyenv"

if [[ -d "$PYENV_ROOT/bin" ]]; then
  path_prepend "$PYENV_ROOT/bin"
fi

if [[ -d "$(brew --prefix)/opt/libpq/bin" ]]; then
  path_prepend "$(brew --prefix)/opt/libpq/bin"
fi

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
  eval "$(pyenv virtualenv-init -)"
fi

if command -v brew >/dev/null 2>&1; then
  if [[ -s "$(brew --prefix)/etc/autojump.sh" ]]; then
    . "$(brew --prefix)/etc/autojump.sh"
  fi

  if [[ -s "$(brew --prefix)/share/antigen/antigen.zsh" ]]; then
    . "$(brew --prefix)/share/antigen/antigen.zsh"
  fi
fi

if [[ -s "/usr/share/zsh-antigen/antigen.zsh" ]]; then
  . /usr/share/zsh-antigen/antigen.zsh
fi

if [[ -s "$HOME/.secrets" ]]; then
  . "$HOME/.secrets"
fi

if [[ -d "$HOME/.local/share/bob/nvim-bin" ]]; then
  path_prepend "$HOME/.local/share/bob/nvim-bin"
fi

autoload -U +X compinit && compinit
source "$HOME/dotfiles/.config/fzf/config.sh"
source "$HOME/dotfiles/.config/obsidian/config.sh"
source "$HOME/dotfiles/.config/nvim/config.sh"

# neovim
if [[ "$(uname -s)" == "Linux" ]]; then
  export NVIM_DIR="/opt/nvim-linux-x86_64/bin"
  path_prepend "$NVIM_DIR"
fi

# Antigen
antigen use oh-my-zsh
antigen theme robbyrussell
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle autojump
antigen bundle jeffreytse/zsh-vi-mode

antigen apply

# Aliases
alias gph="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch -a"
alias gcm="git commit -am $1"

alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcb="docker compose build"
alias dcl="docker compose logs -f"
alias dcr="docker compose restart"
alias dcfr="docker compose down && docker compose up -d"

alias npmviewlink="npm ls -g --depth=0 --link=true"
alias gprune="$HOME/dotfiles/scripts/git-prune.sh"

alias ls="eza --color=always --long --git --icons=always --time=modified"
alias cp="cp --interactive"

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

function _tmux_rename_from_pwd() {
  [[ -n "$TMUX" ]] || return

  local repo name
  repo=$(command git -C "$PWD" rev-parse --show-toplevel 2>/dev/null) || repo=""
  if [[ -n "$repo" ]]; then
    name=${repo:t}
  else
    name=${PWD:t}
  fi

  tmux rename-window -- "$name"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _tmux_rename_from_pwd
