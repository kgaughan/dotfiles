#!/usr/bin/awk -f
#
# Parses shared objects to be linked to from the output of ldd.
#

/^[[:space:]]+([^[:space:]]+) => ([^[:space:]]+) \(0x[0-9a-f]+)$/ {
	print $3
}

/^[[:space:]]+(\/[^[:space:]]+) \(0x[0-9a-f]+)$/ {
	print $1
}
