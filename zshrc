# Idea adapted from http://lumberjaph.net/app/2008/06/18/keep-your-zshrc-simple.html
autoload -U compinit zrecompile zmv
compinit -d ~/.cache/zcompdump
for f in ~/.zshrc ~/.cache/zcompdump; do
	zrecompile -p $f >/dev/null 2>&1 && rm -f $f.zwc.old
done
for f in ~/.config/zsh.d/S??.*.zsh ~/.zshrc.local; do
	if test -e $f; then
		zrecompile -p $f >/dev/null 2>&1 && rm -f $f.zwc.old
		source $f
	fi
done
function history-all {
	history -E 1
}
