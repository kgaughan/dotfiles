[ -z "$PS1" ] && return
test -x /usr/bin/lesspipe && eval "$(SHELL=/bin/sh lesspipe)"
for snippet in $HOME/.config/bash.d/S??.*; do
	. $snippet
done
