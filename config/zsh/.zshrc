# zmodload zsh/zprof

export TERM=xterm-256color

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/oh-my-zsh"

# EDIT THIS FILE with these aliases
alias e="subl"
alias zshrc="e $ZDOTDIR/.zshrc"
alias zconfig="e $ZDOTDIR/.zshrc"
alias zenv="e $HOME/.zshenv"
alias dotfiles="e ~/dotfiles/"

# Zsh Theme
ZSH_THEME="zsh2000"
export ZSH_2000_DISABLE_RIGHT_PROMPT='true'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# update automatically without asking
zstyle ':omz:update' mode disabled

# Set how often to auto-update (in days).
zstyle ':omz:update' frequency 365


# =======
# PLUGINS
# =======

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# plugins=(macos iterm2 brew git zoxide colored-man-pages zsh-autosuggestions)
# NOTE: zsh-completions is lodaded, just not listec here
plugins=(iterm2 colored-man-pages zoxide virtualenv)



# =========================
# ========= Pre-init iTerm2
# =========================

if [[ "$OSTYPE" == darwin* ]] && [[ -n "$ITERM_SESSION_ID" ]] ; then
    zstyle :omz:plugins:iterm2 shell-integration yes
    source $HOME/.config/scripts/iterm.sh
fi


# =========================
# ========== Pre-init `path`
# =========================

# typeset -U path PATH
path+=(~/Library/Application\ Support/JetBrains/Toolbox/scripts)
path+=(/Applications/Sublime\ Text.app/Contents/SharedSupport/bin)
path+=(/Library/Application\ Support/org.pqrs/Karabiner-Elements/bin)
path+=(~/go/bin)


# Required to cache formula and cask descriptions.
export HOMEBREW_EVAL_ALL="true"



# =========================
# ========= Pre-init `fpath`
# =========================

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)

# zsh-completions plugin is "loaded" here (as opposed to the standard `plugins`)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src


# Add any custom completions before this line:
autoload -U compinit && compinit





# =========================
# ======== Source oh-my-zsh
# =========================

source $ZSH/oh-my-zsh.sh

# Override some oh-my-zsh stuff
# Prevent individual sessions from sharing history
# unsetopt inc_append_history
# unsetopt share_history


### Interseting ones, check out later
# /Users/ryan/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# ==================
# User configuration
# ==================


if [[ $+commands[pwgen] && -n "$HOME/dotfiles/script/password.sh" ]]; then
    source "$HOME/dotfiles/script/password.sh"
fi

# Lists environment variables, sorted
alias vars='env | sort'
alias lsfpath='echo $FPATH | sed "s/:/\n/g"'

# navigation
cx() { cd "$@" && ll; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && ll; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { e "$(find . -type f -not -path '*/.*' | fzf)" }


# ====================
# Cheat - shell cheatsheets
# ====================

export CHEAT_CONFIG_PATH="~/dotfiles/config/cheat/conf.yml"



# ====================
# UM - custom manpages (more custom cheatsheets)
# ====================

export UMCONFIG_HOME="$XDG_CONFIG_HOME/um"



# ====================
# BAT - `cat` with color`
# ====================

export BAT_THEME="Dracula"
export JQ_COLORS="0;90:1;31:1;35:1;33:0;32:1;39:1;39:1;34"

alias ogcat=/bin/cat
alias cat=/opt/homebrew/bin/bat



# ====================
# NeoVim/editor
# ====================

alias oldvim=$(which vim)
alias vim="nvim"
alias v="nvim"
alias vimconfig='e ~/.config/nvim/init.lua'



# ====================
# LSD (LS-Deluxe)
# ====================

lsd_common="--date relative"

alias elsd="lsd $lsd_common"
# - LSD LIST:  "-l" = long format; "-A" = "almost-all" (hides "." and "..")
alias ll="elsd -lA"
# - LSD ALL
alias la='elsd -lA -I ""'
# - LSD TREE - Show tree style
alias lt='elsd --tree -A --depth 2'
alias ltt='elsd --tree -A --depth 3'
alias lttt='elsd --tree -A --depth 4'
alias ltttt='elsd --tree -A --depth 5'
alias lttttt='elsd --tree -A --depth 6'
# - LSD Sort by last-modified (newest on bottom)
alias ltr='elsd -lAtr'
# - LSD Sort by file extension
alias lex='elsd -lAX'



# ==================
# VIVID (and colors in general)
# ==================

export VIVID_THEME='molokai'
export LS_COLORS="$(vivid generate $VIVID_THEME)"

alias __ls=/bin/ls
alias ls='gls --color'



# ==================
# BORDERS
# ==================

# Move this to .zprofile/.login to be defined in .bordersrc
# Would be cool to get this from vivid direct
export JANK_BORDER_ACTIVE='00ff87'



# ==================
# FZF - Fuzzy Finder
# ==================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# - Fuzzy-Find to editor
function fzv {
    fzf --preview 'bat --style=numbers --color=always {}' | xargs -n 1 subl
}


# ==================
# YAZI - TUI File Explorer
# ==================

# alias ya=yazi



# ==================
# YABAI - WINDOW TILES
# ==================

alias ya='yabai -m'
alias yaq='yabai -m query'



# ==================
# LPORG - manage launchpad
# ==================

# https://github.com/blacktop/lporg
alias lporg="lporg -c $XDG_CONFIG_HOME/lporg/config.yml"



# ==================
# ZELLIG - like tmux
# ==================

export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"



# ==================
# PNPM
# ==================

export PNPM_HOME="/Users/ryan/.config/.local/share/pnpm"

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) path+=($PNPM_HOME) ;;
esac

alias pn=pnpm
alias pnx='pnpm exec'



# ==================
# ALIASES/FUNCS
# ==================


# source $HOME/.config/scripts/notify.sh

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


# ==================
# GITIGNORE
# ==================

# See: https://docs.gitignore.io/install/command-line
function gi() {
    curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;
}

function gitpick() {
    git checkout $1 -- $2
}


# ==================
# MISE - Environment Manager
# ==================

# eval "$(mise activate zsh)"


# ==================
# ENVMAN - Environment Manager
# ==================

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


# ==================
# PYENV - Python Environment Manager
# ==================

export PYENV_ROOT="$HOME/.pyenv"

[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init - zsh)"


