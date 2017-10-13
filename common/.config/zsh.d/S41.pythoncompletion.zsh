# See: https://github.com/jbisbee/python-shell-enhancement

if test -e "$HOME/.local/share/python/pythonstartup.py"; then
    export PYTHONSTARTUP="$HOME/.local/share/python/pythonstartup.py"
    export PYTHON_HISTORY_FILE="${XDG_CACHE_HOME-$HOME/.cache}/python_history"
fi