export WORKON_HOME=$HOME/.virtualenvs

# Try the relatively sane options first.
while read i; do
	if test ! -z "$i" -a -e "$i"; then
		export VIRTUALENVWRAPPER_SCRIPT="$i"
		break
	fi
done <<FIN
/usr/share/virtualenvwrapper/virtualenvwrapper.sh
$(which virtualenvwrapper 2>/dev/null >&2)
$(which virtualenvwrapper.sh 2>/dev/null >&2)
/etc/bash_completion.d/virtualenvwrapper
FIN

if [ -z "$VIRTUALENVWRAPPER_SCRIPT" ]; then
	echo "ERROR: Could not find virtualenvwrapper" >&2
else
	# Load the real implementation of the API from virtualenvwrapper.sh
	function virtualenvwrapper_load {
		source "$VIRTUALENVWRAPPER_SCRIPT"
	}

	# Set up "alias" functions based on the API definition.
	function virtualenvwrapper_setup_lazy_loader {
		typeset venvw_name
		for venvw_name in mkvirtualenv rmvirtualenv lsvirtualenv showvirtualenv workon add2virtualenv cdsitepackages cdvirtualenv lssitepackages toggleglobalsitepackages cpvirtualenv setvirtualenvproject mkproject cdproject mktmpenv; do
			eval "
function $venvw_name {
	virtualenvwrapper_load
	$venvw_name \"\$@\"
}
"
		done
	}

	virtualenvwrapper_setup_lazy_loader
fi
