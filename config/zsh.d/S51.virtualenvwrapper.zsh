export WORKON_HOME=$HOME/.virtualenvs

_source_first () {
	file=$1
	shift
	while test $# -gt 0; do
		if test -e $1/$file; then
			source $1/$file
			break
		fi
		shift
	done
}

_source_first virtualenvwrapper_lazy.sh /usr/local/bin /usr/share/virtualenvwrapper

unset -f _source_first
