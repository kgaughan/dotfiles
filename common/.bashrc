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
export LC_CTYPE=en_IE.UTF-8
export LC_ALL=en_IE.UTF-8
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

# ssh-agent {{{

ssh_agent_env=$HOME/.ssh/agent.env

ssh_agent_is_running() {
	if test -n "${SSH_AUTH_SOCK:-}"; then
		# 0 = running, has keys
		# 1 = running, no keys
		# 2 = not running
		ssh-add -l >/dev/null 2>&1 || test $? -eq 1
	else
		false
	fi
}

if ! ssh_agent_is_running && test -e $ssh_agent_env; then
	source $ssh_agent_env
fi

if ! ssh_agent_is_running; then
	(umask 077; ssh-agent | tee $ssh_agent_env) | source -
	ssh-add
elif ! ssh-add -l >/dev/null 2>&1; then
	ssh-add
fi >/dev/null

unset ssh_agent_env

# }}}
