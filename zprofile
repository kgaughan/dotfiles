if which keychain >/dev/null; then
	# Note: keychain pre-2.8.0, is incompatible with gnupg post-2.1, so if
	# it breaks, that's why. Use '--agents ssh' to disable it.
	eval `keychain --agents ssh,gpg --timeout 14400 --quiet --noask --eval id_rsa CF9F6473`
fi
if test "$DISPLAY" = ""; then
	export GPG_TTY=`tty`
fi
