export WORKON_HOME=$HOME/.virtualenvs

export VIRTUALENVWRAPPER_SCRIPT="$(which virtualenvwrapper.sh 2>/dev/null >&2)"
if [ -z "$VIRTUALENVWRAPPER_SCRIPT" ]; then
	if [ -e /etc/bash_completion.d/virtualenvwrapper ]; then
		export VIRTUALENVWRAPPER_SCRIPT=/etc/bash_completion.d/virtualenvwrapper
	else
		echo "ERROR: virtualenvwrapper_quick.sh: Could not find virtualenvwrapper.sh" >&2
	fi
fi

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
