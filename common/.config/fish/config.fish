# fish setup to prevent some annoyances
set fish_greeting
set fish_help_browser w3m

# file permissions: rwxr-xr-x
umask 022

for dir in /usr/{local,pkg}/{sbin,bin} \
		   ~/Library/Python/{2.7,3.6}/bin \
		   ~/.local/bin
	if not contains $dir $PATH; and test -d $dir
		set -x PATH $dir $PATH
	end
end

set -q LIBDIRPATH; or set -x LIBDIRPATH /usr/local/lib /usr/lib /lib
set -x LIBDIRPATH $LIBDIRPATH ~/.local/lib

for i in most less more
	if which $i >/dev/null
		set -x PAGER (which $i)
		break
	end
end

for i in vim vi
	if which $i >/dev/null
		set -x EDITOR (which $i)
		break
	end
end

# golang
set -x GOPATH ~/projects/go
test -d $GOPATH/bin; or mkdir -p $GOPATH/bin
set -x PATH $PATH $GOPATH/bin

if not set -q XDG_CACHE_HOME
	set -x XDG_CACHE_HOME ~/.cache
end

# python completion
if test -e ~/.local/share/python/pythonstartup.py
	set -x PYTHONSTARTUP ~/.local/share/python/pythonstartup.py
	set -x PYTHON_HISTORY_FILE $XDG_CACHE_HOME/python_history
end

# lynx style sheet
test -e ~/.lynx.lss; and set -x LYNX_LSS ~/.lynx.lss

if status is-interactive
	alias m $PAGER
	alias h "fc -l"
	alias j jobs
	alias ll "ls -hlaFo"
	alias l "ls -hl"
	alias g "egrep -l"
	alias untar "tar xf"
	alias md "mkdir -p"
	alias ff "find . -name"
	alias du "du -h"
	alias df "df -h"
	# paranoia
	alias rm "rm -i"
	# a common typo of mine
	alias cd.. "cd .."
	# make the ocaml repl usable
	which ledit >/dev/null; and alias ocaml 'ledit ocaml'
	# fun stuff
	which curl >/dev/null; and alias weather 'curl wttr.in/dublin'

	# csh syntax is compatible enough with fish for this to work
	if test -x /usr/bin/dircolors
		if test -r ~/.dircolours
			eval (dircolors -c ~/.dircolors)
		else
			eval (dircolors -c)
		end

		alias ls "ls -F --color=auto"
		alias grep "grep --color=auto"
		alias fgrep "fgrep --color=auto"
		alias egrep "egrep --color=auto"
	else
		alias ls "ls -F"
	end
end

# Local config not necessarily under version control.
test -e ~/.fish.local; and source ~/.fish.local
