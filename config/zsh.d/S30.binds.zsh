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

# For FreeBSD console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
