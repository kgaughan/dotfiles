# ~/.profile: executed by the command interpreter for login shells.

# the default umask is set in /etc/profile
# On Debian/Ubuntu, to sett the umask for ssh logins, install and
# configure the libpam-umask package.
umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
