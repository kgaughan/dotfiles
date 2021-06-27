test -e $HOME/.local/bin && export PATH=$HOME/.local/bin:$PATH

if command -v go >/dev/null; then
	export PATH=${GOPATH:=$HOME/go}/bin:$PATH
	export GOPATH
fi
