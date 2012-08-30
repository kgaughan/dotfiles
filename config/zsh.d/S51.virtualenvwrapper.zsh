for i in /etc/bash_completion.d/virtualenvwrapper; do
	if test -e $i; then
		source $i
		break
	fi
done
