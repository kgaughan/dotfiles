autoload -U compinit zrecompile zmv
zsh_cache=$HOME/.cache/zsh
mkdir -p $zsh_cache
compinit -d $zsh_cache/zcomp-$HOST
for f in ~/.zshrc $zsh_cache/zcomp-$HOST; do
	zrecompile -p $f && rm -f $f.zwc.old
done
for snippet in $HOME/.config/zsh.d/S??.*; do
	source $snippet
done
function history-all { history -E 1 }
