export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.config/.cache"
export XDG_DATA_HOME="$HOME/.config/.local/share"

# Where Zsh dotfiles live
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Other pre-zsh-loaded environment bariables
export EDITOR="nvim"
export VISUAL="nvim"

source $XDG_CONFIG_HOME/zsh/notify.sh
source $XDG_CONFIG_HOME/yabai/yabai.sh
source $XDG_CONFIG_HOME/skhd/skhd-func.sh

export STARTUP_FILES=".zshenv:$STARTUP_FILES"
