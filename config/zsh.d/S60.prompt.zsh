if [ x$WINDOW != x ]; then
	export PS1="%B%m%b($WINDOW):%B%~%b%E
%# "
else
	export PS1="%B%m%b:%B%~%b%E
%# "
fi

# Format titles for screen and rxvt
# From http://dotfiles.org/~daragh/.zshrc
function title() {
	# Escape '%' chars in $1, make nonprintables visible
	a=${(V)1//\%/\%\%}

	# Truncate command, and join lines.
	a=$(print -Pn "%40>...>$a" | tr -d "\n")

	case $TERM in
	screen)
		# Screen title (in ^A")
		print -Pn "\ek$a:$3\e\\"
		;;
	xterm* | rxvt)
		# Plain xterm title
		print -Pn "\e]2;$2 | $a:$3\a"
		;;
	esac
}

# Precmd is called just before the prompt is printed
function precmd() {
	title "zsh" "$USER@%m" "%55<...<%~"
}

# Preexec is called just before any command line is executed
function preexec() {
	title "$1" "$USER@%m" "%35<...<%~"
}
