setup_autojump() {
    local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autojump"

    if [ ! -d "$plugin_dir" ]; then
        echo "Cloning autojump..."
        git clone https://github.com/wting/autojump.git "$plugin_dir" 
        cd "$plugin_dir" && ./install.py
        echo "autojump installed successfully"
    fi
}

setup_zsh_autosuggestions() {
    local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

    if [ ! -d "$plugin_dir" ]; then
        echo "Cloning zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir" 
        echo "zsh-autosuggestions installed successfully"
    fi
}

setup_zsh_plugins() {
  setup_autojump
  setup_zsh_autosuggestions
}

setup_environment_variables() {
  if [ ! -d "$HOME/dotfiles/scripts" ]; then
    echo "Missing scripts directory"
  else
    ~/dotfiles/scripts/setup-env.sh
  fi
}

setup_zsh_plugins
setup_environment_variables

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"

plugins=(
  git
  zsh-autosuggestions
  autojump
)

source $ZSH/oh-my-zsh.sh

# Git 
alias gph="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch -a"
alias gcm="git commit -am $1"

# Custom aliases
alias npmviewlink="npm ls -g --depth=0 --link=true"
alias gprune="$HOME/dotfiles/scripts/gitprune.sh"

export HOMEBREW_DIR="/opt/homebrew/bin"
export VSCODE_DIR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export MVN_DIR="/opt/apache-maven-3.8.6/bin"
export NVM_DIR="$HOME/.nvm"
export TEX_DIR="/Library/TeX/texbin"
export PATH=${HOMEBREW_DIR}:${MVN_DIR}:${TEX_DIR}:${CONDA_DIR}:$PATH:${VSCODE_DIR}

# Docker
source /Users/jerald/.docker/init-zsh.sh || true # Added by Docker Desktop

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

# pyenv 
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"

# fzf
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
