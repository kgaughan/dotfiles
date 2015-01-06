if which keychain >/dev/null; then
	# Temporarily disabling the gpg agent due to issues in gnupg 2.1.
	# http://permalink.gmane.org/gmane.linux.gentoo.funtoo.devel/6567
	eval `keychain --agents ssh --timeout 14400 --quiet --noask --eval id_rsa CF9F6473`
fi
if test "$DISPLAY" = ""; then
	export GPG_TTY=`tty`
fi
