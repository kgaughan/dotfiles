#!/bin/sh
#
# Link generation script

here=$(readlink -fn .)

make_links () {
	while read file; do
		echo $here/$file $1${file##*/}
	done
}

link_dirs () {
	while read path; do
		for i in $path/*; do
			echo $i
		done | make_links $HOME/.$path/
	done
}

make_links $HOME/. <<FIN
dialogrc
docutils
face.png
fdm.conf
gitconfig
gnupg
ipython
irssi
mailcap
mostrc
muttrc
pylintrc
tmux.conf
vim
vimrc
Xdefaults
zprofile
zshenv
zshrc
FIN

link_dirs <<FIN
config
gnupg
irssi
local/bin
local/share/python
pip
ssh
FIN

# machines
# misc
