zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' max-errors 0 not-numeric
zstyle :compinstall filename "$HOME/.zshrc"

if which kubectl] >/dev/null; then
	source <(kubectl completion zsh)
fi
