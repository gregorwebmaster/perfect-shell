export PATH=$HOME/Android/Sdk/platform-tools:$HOME/bin:/usr/local/bin:$HOME/projects/scripts:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DIO_SCRIPTS_DIR=$HOME/projects/scripts/

#ZSH_THEME="bureau"
ZSH_THEME="agnoster"

plugins=(git git-flow docker symfony colorize aliases debian)

source $ZSH/oh-my-zsh.sh

source $HOME/.aliases
