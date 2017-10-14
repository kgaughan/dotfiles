# Try the relatively sane options first.
while read i; do
	if test -e "$i"; then
		export X_VIRTUALENVWRAPPER_SCRIPT="$i"
		break
	fi
done <<FIN
/usr/share/virtualenvwrapper/virtualenvwrapper.sh
/etc/bash_completion.d/virtualenvwrapper
/usr/local/bin/virtualenvwrapper.sh
FIN

if [ ! -z "$X_VIRTUALENVWRAPPER_SCRIPT" ]; then
	export WORKON_HOME=$HOME/.virtualenvs

	# Load the real implementation of the API from virtualenvwrapper.sh
	function virtualenvwrapper_load {
		source "$X_VIRTUALENVWRAPPER_SCRIPT"
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