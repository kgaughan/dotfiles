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

bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word
#bindkey "^[a" beginning-of-line
#bindkey "^[e" end-of-line

# For FreeBSD console
# See 'man 5 termcap' for a list of codes passed to echotc
bindkey "$(echotc kh)" beginning-of-line
bindkey "$(echotc @7)" end-of-line
