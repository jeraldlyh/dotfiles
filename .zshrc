setup_zsh_autosuggestions() {
    local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

    if [ -d "$plugin_dir" ]; then
        echo "zsh-autosuggestions is already installed"
    else
        echo "Cloning zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir" 
        echo "zsh-autosuggestions installed successfully"
    fi
}

setup_zsh_plugins() {
  echo "Setting up zsh plugins..."
  setup_zsh_autosuggestions
  echo "Plugins setup successfully"
}

setup_zsh_plugins

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
ENABLE_CORRECTION="true"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration
alias gph="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch -a"
alias gcm="git commit -am $1"
alias npmviewlink="npm ls -g --depth=0 --link=true"
alias gprune="$HOME/gitprune.sh"
alias cs443="ssh -X jeraldlim.2020@118.189.242.72 -p 57151"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias cs302="j mainlab && ssh -i cs302-lab.pem ec2-user@52.15.231.208"
alias is113="cd /Applications/MAMP/htdocs && code ."

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
