# fish setup to prevent some annoyances
set fish_greeting

# file permissions: rwxr-xr-x
umask 022

# fish_add_path ~/.local/bin /usr/local/go/bin /usr/{local,pkg}/{sbin,bin}
for dir in /usr/{local,pkg}/{sbin,bin} /opt/homebrew/bin /usr/local/go/bin ~/.local/bin
	if not contains $dir $PATH; and test -d $dir
		set -x PATH $dir $PATH
	end
end

if command -s w3m
	set fish_help_browser w3m -o confirm_qq=false
end >/dev/null

set -q LIBDIRPATH; or set -x LIBDIRPATH /usr/local/lib /usr/lib /lib
set -x LIBDIRPATH $LIBDIRPATH ~/.local/lib

for i in most less more
	if command -s $i
		set -x PAGER (command -s $i)
		break
	end
end >/dev/null

for i in vim vi
	if command -s $i
		set -x EDITOR (command -s $i)
		break
	end
end >/dev/null

# golang
if command -s go
	set -x GOPATH ~/go
	test -d $GOPATH/bin; or mkdir -p $GOPATH/bin
	# fish_add_path $GOPATH/bin
	set -x PATH $PATH $GOPATH/bin
end >/dev/null

if command -s dotnet
	set -x DOTNET_CLI_TELEMETRY_OPTOUT true
end >/dev/null

if not set -q XDG_CACHE_HOME
	set -x XDG_CACHE_HOME ~/.cache
end

# lynx style sheet
set -x LYNX_LSS ~/.config/lynx.lss

if status is-interactive
	alias dummy-mailer "python3 -m smtpd -n --class=DebuggingServer localhost:1025"
	if command -s ged
		# On MacOS, the ed is so old that it lacks -v support, so use ged.
		alias ed "ged -v -p '> '"
	else
		alias ed "ed -v -p '> '"
	end
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
	if command -s ocaml; and command -s ledit
		alias ocaml 'ledit ocaml'
	end
	command -s neomutt; and alias mutt neomutt
	command -s tmux; and alias s "tmux has; and tmux attach; or tmux"
	# fun stuff
	command -s curl; and alias weather 'curl "wttr.in/dublin?m"'

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

	# Quickly SSH into an a server.
	for host in eimhir lir manann
		alias $host "ssh -t $host.talideon.com s"
	end
	alias tilde "ssh -t tilde.club s"
	alias sdf "ssh -t talideon@sdfeu.org"

	if not set -q ANDROID_ROOT; and not set -q SSH_AUTH_SOCK
		eval (ssh-agent -c)
	end

	if command -s pyenv
		set -Ux PYENV_ROOT ~/.pyenv
		pyenv init --path | source
		pyenv init - | source
		pyenv virtualenv-init - | source
	end

	command -s opam; and eval (opam env)
end >/dev/null

# Local config under version control.
test -e ~/.fish.local; and source ~/.fish.local

# Local config *not* under version control.
test -e ~/.fish.pvt; and source ~/.fish.pvt
