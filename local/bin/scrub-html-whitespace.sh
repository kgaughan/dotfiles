#!/bin/bash
#
# Cleans up basic whitespace problems in .html files. Run before commits.
#

# Spaces to tabs.
for i in `find . -name \*.html`; do
    if test -f $i; then
		tmp=`mktemp`
		unexpand -t4 --first-only $i >$tmp
		mv $tmp $i
	fi
done


# Trailing whitespace
for i in `egrep -rl '[[:space:]]$' --include=\*.html .`; do
	if test -f $i; then
		sed -i 's/\s\+$//g' $i 2>/dev/null
	fi
done

# Trailing and leading lines
find . -name \*.html -type f -exec sed -i -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' {} \;