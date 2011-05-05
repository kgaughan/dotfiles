## Set up $PATH
PATH=/sbin:/usr/sbin:/bin:/usr/bin
for dir in /usr/{local,pkg}/{sbin,bin} /usr/games; do
	if test -d "$dir"; then
		PATH="$PATH:$dir"
	fi
done
export PATH="$PATH:$HOME/.local/bin"

## Set up $LIBDIRPATH
if test "x$LIBDIRPATH" = "x"; then
	LIBDIRPATH="/usr/local/lib:/usr/lib:/lib"
fi
LIBDIRPATH="$LIBDIRPATH:$HOME/.local/lib"
export LIBDIRPATH

## Locale settings
export LANG=en_IE.UTF-8
export LC_ALL=en_IE.UTF-8
export LC_CTYPE=en_IE.UTF-8

## Zsh history-related
export HISTFILE=~/.zhistfile
export HISTSIZE=500000
export SAVEHIST=100000

## Default editor
which vim >/dev/null && EDITOR=vim || EDITOR=vi; export EDITOR

## ...and default page.
if test "x$PAGER" = "x"; then
	for pager in most less more; do
		if which $pager 2>&1 >/dev/null; then
			export PAGER=`which $pager`
			break
		fi
	done
fi

## gpg-agent
#if test -f $HOME/.gpg-agent-info; then
#	. $HOME/.gpg-agent-info
#	export GPG_AGENT_INFO
#	export SSH_AUTH_SOCK
#	export SSH_AGENT_PID
#fi

## Miscellany
export BLOCKSIZE=K
