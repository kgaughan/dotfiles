# Idea adapted from http://lumberjaph.net/app/2008/06/18/keep-your-zshrc-simple.html
autoload -U compinit zrecompile zmv
zsh_cache=$HOME/.cache/zsh
mkdir -p $zsh_cache
compinit -d $zsh_cache/zcomp-$HOST
for f in ~/.zshrc $zsh_cache/zcomp-$HOST; do
	zrecompile -p $f >/dev/null 2>&1 && rm -f $f.zwc.old
done
for snippet in $HOME/.config/zsh.d/S??.*; do
	source $snippet
done
function history-all {
	history -E 1
}
