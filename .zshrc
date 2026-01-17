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
fi

# pyenv 
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"

  if [[ -d $PYENV_ROOT/shims ]]; then
    path_prepend "$PYENV_ROOT/bin"
  fi
  
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
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
