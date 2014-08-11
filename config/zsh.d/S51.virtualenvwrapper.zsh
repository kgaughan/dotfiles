export WORKON_HOME=$HOME/.virtualenvs

# Try the relatively sane options first.
for i in virtualenvwrapper virtualenvwrapper.sh; do
	if which $i 2>/dev/null >&2; then
		export VIRTUALENVWRAPPER_SCRIPT="$(which $i)"
		break
	fi
done

if [ -z "$VIRTUALENVWRAPPER_SCRIPT" ]; then
	# OK, let's give Debian a stab now.
	if [ -e /etc/bash_completion.d/virtualenvwrapper ]; then
		export VIRTUALENVWRAPPER_SCRIPT=/etc/bash_completion.d/virtualenvwrapper
	else
		echo "ERROR: Could not find virtualenvwrapper" >&2
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
