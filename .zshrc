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
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
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
alias gprune="$HOME/gitprune.sh"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

export HOMEBREW_DIR="/opt/homebrew/bin"
export VSCODE_DIR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export MVN_DIR="/opt/apache-maven-3.8.6/bin"
export NVM_DIR="$HOME/.nvm"
export TEX_DIR="/Library/TeX/texbin"
export CONDA_DIR="/opt/homebrew/anaconda3/bin"
export PATH=${HOMEBREW_DIR}:${MVN_DIR}:${TEX_DIR}:${CONDA_DIR}:$PATH:${VSCODE_DIR}

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
. "/Users/jerald/.acme.sh/acme.sh.env"

source /Users/jerald/.docker/init-zsh.sh || true # Added by Docker Desktop
