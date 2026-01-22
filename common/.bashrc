# This exists for the limited set of places I'm forced to use bash.

test -e $HOME/.profile && source $HOME/.profile

# Exit early if not running interactively {{{
case $- in
	*i*) ;;
	*) return;;
esac
# }}}

# Ensure history is sane {{{
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
# }}}

# Locale {{{
export LANG=en_US.UTF-8
# }}}

# PATH {{{
test -e $HOME/.local/bin && export PATH=$HOME/.local/bin:$PATH
if command -v go >/dev/null; then
	export PATH=${GOPATH:=$HOME/go}/bin:$PATH
	export GOPATH
fi
# }}}

# aliases {{{
# }}}
