## Set up $PATH
PATH=/sbin:/usr/sbin:/bin:/usr/bin
for dir in /usr/{local,pkg}/{sbin,bin} /usr/games; do
	if test -d "$dir"; then
		PATH="$PATH:$dir"
	fi
done

while read bin_path; do
	if test -d "$bin_path"; then
		export PATH="$bin_path:$PATH"
	fi
done <<-FIN
$HOME/.opt/PebbleSDK/bin
$HOME/Library/Python/2.7/bin
$HOME/Library/Python/3.6/bin
$HOME/.pyenv/bin
$HOME/.local/bin
FIN

which pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

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

_assign_first_cmd () {
	var=$1
	shift
	for cmd in $*; do
		if which $cmd 2>&1 >/dev/null; then
			export $var=$(which $cmd)
			break
		fi
	done
}

_assign_first_cmd EDITOR mvim vim vi
_assign_first_cmd PAGER most less more

## This dance makes sure that if if TERM is 'blah' or 'blah-256color', it
## always ends up 'blah-256color'. This is necessary to get tmux and vim
## playing nice with the more idiotic terminal emulators out there.
if test "$TERM" = "screen" -o "$TERM" = "xterm"; then
	export TERM=${TERM%-256color}-256color
fi

## Miscellany
export BLOCKSIZE=K

test -e ~/.zshenv.local && source ~/.zshenv.local
