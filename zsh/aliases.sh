#===============================================================
#
# ALIASES AND FUNCTIONS
#
##===============================================================

# Shortcuts
alias code='cd ~/Code'
alias reload='source ~/.bashrc'
alias path='echo -e ${PATH//:/\\n}'

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# List all files colorized in long format
alias ll="ls -alF"

# List only directories
alias lsd='ll | grep "^d"'

# Simple webserver for the directory contents running at localhost:8080
export PY_TEST_PORT=8080
alias pyserver3='python3 -m http.server $PY_TEST_PORT'
alias pyserver2='python -m SimpleHTTPServer $PY_TEST_PORT'

function server() {
  if [[ "$(python3 -V)" =~ "Python 3" ]]
  then
    pyserver3
  else
    pyserver2
  fi
}
# ----------------------------------------------------------------------
# Safeguards
# ----------------------------------------------------------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

# ----------------------------------------------------------------------
# ls less With DIRCOLORS
# ----------------------------------------------------------------------

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
fi
