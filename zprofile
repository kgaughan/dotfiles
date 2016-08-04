if which keychain >/dev/null; then
	eval `keychain --agents ssh,gpg --timeout 14400 --quiet --noask --eval id_rsa CF9F6473`
fi
if test "$DISPLAY" = ""; then
	export GPG_TTY=`tty`
fi
