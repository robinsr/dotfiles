export TERM=xterm-256color
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/oh-my-zsh"

# EDIT THIS FILE with these aliases 
alias zshrc="e $ZDOTDIR/.zshrc"
alias zconfig="e $ZDOTDIR/.zshrc"
alias zenv="e $HOMW/.zshenv"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="zsh2000"
export ZSH_2000_DISABLE_RIGHT_PROMPT='true'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# =======
# PLUGINS
# =======

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(macos iterm2 brew git zoxide colored-man-pages zsh-autosuggestions)

zstyle :omz:plugins:iterm2 shell-integration yes

# ======
# PRE-OHMYZSH-INIT STUFF 
# ======

# Adds webstorm and other Jetbrains apps to path 
export PATH="$PATH:/Users/ryan/Library/Application Support/JetBrains/Toolbox/scripts"

# Adds Sublime Text executable to path
export PATH="$PATH:Applications/Sublime Text.app/Contents/SharedSupport/bin"

export PATH="$PATH:/Library/Application Support/org.pqrs/Karabiner-Elements/bin"

# ================
# Source oh-my-zsh 
# ================

source $ZSH/oh-my-zsh.sh

# Override some oh-my-zsh stuff
# Prevent individual sessions from sharing history
unsetopt inc_append_history
unsetopt share_history


### Interseting ones, check out later
# /Users/ryan/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh


# ==================
# User configuration
# ==================

# Lists environment variables, sorted
alias vars='env | sort'
alias lsfpath='echo $FPATH | sed "s/:/\n/g"'

export BAT_THEME="Dracula"

# =============
# NeoVim/editor
# =============
alias oldvim=$(which vim)
alias vim="nvim"
alias e="nvim"
alias v="nvim"
alias vimconfig='e ~/.config/nvim/init.lua'


# ===============
# LSD (LS-Deluxe)
# ===============
lsd_common="--date relative"
alias elsd="lsd $lsd_common"
# - LSD LIST
alias ll="elsd -l"
# - LSD ALL
#   (-a = "all", -A = "almost-all" (exclude implied . and ..)
alias la='elsd -lA -I ""'
# - LSD TREE - Show tree style
alias lt='elsd --tree -a --depth 2'
alias ltt='elsd --tree -a --depth 3'
alias lttt='elsd --tree -a --depth 4'
alias ltttt='elsd --tree -a --depth 5'
alias lttttt='elsd --tree -a --depth 6'
# - LSD Sort by last-modified (newest on bottom)
alias lmod='elsd -latr'
# - LSD Sort by file extension
alias lext='elsd -lX'


# =========
# GITIGNORE
# =========

# See: https://docs.gitignore.io/install/command-line
function gi() { 
	curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;
}
function gitpick() {
    git checkout $1 -- $2
}

# =====
# VIVID (and colors in general)
# =====
export VIVID_THEME='molokai'
export LS_COLORS="$(vivid generate $VIVID_THEME)"
alias __ls=/bin/ls
alias ls='gls --color'


# =======
# BORDERS
# =======
# Move this to .zprofile/.login to be defined in .bordersrc 
# Would be cool to get this from vivid direct
export JANK_BORDER_ACTIVE='00ff87'



# ============
# Fuzzy-Finder
# ============
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# - Fuzzy-Find to Vim
function fzv {
    fzf --preview 'bat --style=numbers --color=always {}' | xargs -n 1 nvim
}


# ===================
# YAZI - file browser
# ===================
# alias ya=yazi


# ====================
# YABAI - WINDOW TILES 
# ====================
alias ya='yabai -m'
alias yaq='yabai -m query'


# ========================
# LPORG - manage launchpad
# ========================
# https://github.com/blacktop/lporg
alias lporg="lporg -c $XDG_CONFIG_HOME/lporg/config.yml"


# ==================
# ZELLIG - like tmux
# ==================
export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"


# ====================
# UM - custom manpages
# ====================
export UMCONFIG_HOME="$XDG_CONFIG_HOME/um"


# ====
# PNPM
# ==== 
export PNPM_HOME="/Users/ryan/.config/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
alias pn=pnpm
alias pnx='pnpm dlx'


# =============
# ALIASES/FUNCS
# =============
source $ZDOTDIR/notify.sh
source $ZDOTDIR/iterm.sh

function server {
	python3 -m http.server 8080
}

function reload {
	echo "Reloading zsh..."
	source "$ZDOTDIR/.zshrc"
}

function appId {
    osascript -e "id of app \"$1\""
}

function split-line() {
  sed "s/\s\//\n\//g"
}

function split-on() {
  splt="${1:-\n}"
  sed "s/\\$splt/\n/g"
  # sed $pattern
}

# Troubleshooting - https://github.com/ajeetdsouza/zoxide/issues/336
autoload -Uz compinit
compinit -i
eval "$(zoxide init zsh)"

export CHEAT_CONFIG_PATH="~/dotfiles/config/cheat/conf.yml"

# Required to cache formula and cask descriptions.
export HOMEBREW_EVAL_ALL="true"





