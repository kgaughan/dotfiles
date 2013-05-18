#!/bin/bash
#
# Cleans up basic whitespace problems in .rst and .py files. Run before
# commits.
#

# Tabs to spaces.
for i in `fgrep -rl $'\t' --include=\*.py --include=\*.rst .`; do
	if test -f $i; then
		tmp=`mktemp`
		expand -t4 $i >$tmp
		mv $tmp $i
	fi
done

# Trailing whitespace
for i in `egrep -rl '[[:space:]]$' --include=\*.py --include=\*.rst .`; do
	if test -f $i; then
		sed -i 's/\s\+$//g' $i 2>/dev/null
	fi
done

# Trailing and leading lines
find . -name \*.py -type f -exec sed -i -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' {} \;
find . -name \*.rst -type f -exec sed -i -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' {} \;