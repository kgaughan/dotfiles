ENV=$HOME/.zshrc; export ENV

PATH=/sbin:/bin:/usr/sbin:/usr/bin
for dir in /usr/{pkg,local}/{sbin,bin} /usr/games $HOME/.local/bin; do
	if test "x$dir" != "x${PATH##*$dir*}" -a -d "$dir"; then
		PATH="$PATH:$dir"
	fi
done
export PATH

if test "x$LIBDIRPATH" = "x"; then
	LIBDIRPATH="/usr/local/lib:/usr/lib:/lib"
fi
LIBDIRPATH="$LIBDIRPATH:$HOME/.local/lib"
export LIBDIRPATH

which vim  >/dev/null && EDITOR=vim || EDITOR=vi;  export EDITOR
which most >/dev/null && PAGER=most || PAGER=less; export PAGER

BLOCKSIZE=K; export BLOCKSIZE

# file permissions: rwxr-xr-x
umask 022

if which gpg-agent >/dev/null; then
	if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
		GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
		export GPG_AGENT_INFO
	else
		eval `gpg-agent --daemon`
		echo $GPG_AGENT_INFO >$HOME/.gpg-agent-info
	fi
fi
