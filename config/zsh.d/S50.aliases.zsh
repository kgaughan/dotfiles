## Select the preferred pager.
alias m=$PAGER

## Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls -F --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
else
	alias ls='ls -F'
fi

## Some useful aliases.
alias h='fc -l'
alias j=jobs
alias ll='ls -hlaFo'
alias l='ls -hl'
alias g='egrep -i'
alias untar='tar xf'
alias md='mkdir -p'
alias ff='find . -name $*'
alias du='du -h'
alias df='df -h'
# I'm prone to typing this by accident.
alias cd..='cd ..'
# Make the ocaml repl usable.
which ledit >/dev/null && alias ocaml='ledit ocaml'
alias weather='curl wttr.in/carlow'

# A good idea from Vish
smux () {
	ssh -t $1 tmux attach
}

## Be paranoid.
# alias cp='cp -ip'
# alias mv='mv -i'
alias rm='rm -i'
