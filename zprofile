eval `keychain --timeout 14400 --noask --quiet --eval id_rsa CF9F6473`
if test "$DISPLAY" = ""; then
	export GPG_TTY=`tty`
fi
