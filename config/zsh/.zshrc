export TERM=xterm-256color
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/oh-my-zsh"

# EDIT THIS FILE with these aliases 
alias zshrc="vim $ZDOTDIR/.zshrc"
alias zconfig="vim $ZDOTDIR/.zshrc"


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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# ======
# PRE-OHMYZSH-INIT STUFF 
# ======
#
# (must be done before compinit called in oh-my-zsh)
# Adds homebrew env variables and path
eval "$(/opt/homebrew/bin/brew shellenv)"
# # Adds webstorm and other Jetbrains apps to path 
export PATH="$PATH:/Users/ryan/Library/Application Support/JetBrains/Toolbox/scripts"
# # Adds Sublime Text executable to path
export PATH="$PATH:Applications/Sublime Text.app/Contents/SharedSupport/bin"
eval "$(zoxide init zsh)"

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

alias lsfpath='echo $FPATH | sed "s/:/\n/g"'

export BAT_THEME="Dracula"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# =============
# NeoVim/editor
# =============
alias oldvim=$(which vim)
alias vim="nvim"
alias e="nvim"
alias v="nvim"
alias vimconfig='e ~/.config/nvim/init.lua'


# ===========
# LSD SECTION
# ===========
# Lists environment variables, sorted
alias vars='env | sort'

lsd_common="--date relative"
alias elsd="lsd $lsd_common"
# - LSD LIST
alias ll="elsd -l"
# - LSD ALL
#   (-a = "all", -A = "almost-all" (exclude implied . and ..)
alias la='elsd -lA -I ""'
# - LSD TREE - Show tree style
#     Would be nide to configure the ignore globs
#     Defaults to depth=2, but will accept only the last depth arg (so can override)
alias lt='elsd --tree -a --depth 2'
alias lt3='elsd --tree -a --depth 3'
alias lt4='elsd --tree -a --depth 4'
alias lt5='elsd --tree -a --depth 5'
alias lt6='elsd --tree -a --depth 6'
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
# VIVID
# =====
export VIVID_THEME='molokai'
export LS_COLORS="$(vivid generate $VIVID_THEME)"
alias ls='gls --color'


# =======
# ALIASES/FUNCS
# =============
server () {
	python3 -m http.server 8080
}

reload () {
	echo "Reloading zsh..."
	source "$ZDOTDIR/.zshrc"
}


function appId {
    osascript -e "id of app \"$1\""
}


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
# pnpm end
