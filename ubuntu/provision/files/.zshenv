# path
export PATH="${HOME}/bin:/usr/bin:/bin"

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(colored-man colorize)
source $ZSH/oh-my-zsh.sh

# default editor
export EDITOR='nano'

# compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh key
export SSH_KEY_PATH="~/.ssh/dsa_id"

# zsh git prompt
source $HOME/.zsh-git-prompt/zshrc.sh
