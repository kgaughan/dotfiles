# I love Vim, just not on the command line.
bindkey -e

# C-LeftArrow
bindkey '\e[1;5D' backward-word
# C-RightArrow
bindkey '\e[1;5C' forward-word
# C-UpArrow
bindkey '\e[1;5A' beginning-of-line
# C-DownArrow
bindkey '\e[1;5B' end-of-line

case `uname` in
	FreeBSD)
		# For FreeBSD console
		bindkey '^[OH' beginning-of-line
		bindkey '^[OF' end-of-line
		;;
esac
