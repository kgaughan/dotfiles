## Set up $PATH
PATH=/sbin:/usr/sbin:/bin:/usr/bin
for dir in /usr/{local,pkg}/{sbin,bin} /usr/games; do
	if test -d "$dir"; then
		PATH="$PATH:$dir"
	fi
done
export PATH="$PATH:$HOME/.local/bin"
if test -d $HOME/.pyenv/bin; then
	PATH="$PATH:$HOME/.pyenv/bin"
	eval "$(pyenv init -)"
fi

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

## This dance makes sure that if if TERM is 'blah' or 'blah-256color', it
## always ends up 'blah-256color'. This is necessary to get tmux and vim
## playing nice with the more idiotic terminal emulators out there.
if test "$TERM" = "screen" -o "$TERM" = "xterm"; then
	export TERM=${TERM%-256color}-256color
fi

## Miscellany
export BLOCKSIZE=K

# Go.
export GOPATH=$HOME/Projects/go
mkdir -p $GOPATH
export PATH=$PATH:$GOPATH/bin
