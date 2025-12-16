export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
RPROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}]%{$reset_color%}'

plugins=(git zsh-autosuggestions autojump zsh-vi-mode)

export HOMEBREW_DIR="/opt/homebrew/bin"
export VSCODE_DIR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export MVN_DIR="/opt/apache-maven-3.8.6/bin"
export NVM_DIR="$HOME/.nvm"
export TEX_DIR="/Library/TeX/texbin"
export LOCAL_BIN_DIR="$HOME/.local/bin"
export DOTFILE_DIR="$HOME/dotfiles/scripts"
export OPT_DIR="/opt"
export PATH="${HOMEBREW_DIR}:${MVN_DIR}:${TEX_DIR}:${CONDA_DIR}:${VSCODE_DIR}:${LOCAL_BIN_DIR}:${DOTFILE_DIR}:${OPT_DIR}:$PATH"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

# pyenv 
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
  eval "$(pyenv virtualenv-init -)"
fi

# autojump
if command -v brew >/dev/null 2>&1; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

# source "$HOME/.docker/init-zsh.sh"
source "$HOME/dotfiles/.config/fzf/config.sh"
source "$HOME/dotfiles/.config/obsidian/config.sh"
source "$HOME/dotfiles/.config/nvim/config.sh"
source "$ZSH/oh-my-zsh.sh"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Aliases
alias gph="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch -a"
alias gcm="git commit -am $1"

alias npmviewlink="npm ls -g --depth=0 --link=true"
alias gprune="$HOME/dotfiles/scripts/git-prune.sh"

alias ls="eza --color=always --long --git --icons=always --time=modified"
alias cp="cp --interactive"

if [[ "$(uname -s)" == "Linux" ]]; then
  export NVIM_DIR="/opt/nvim-linux-x86_64/bin"
  export PATH="${NVIM_DIR}:$PATH"
fi
