mkdir -p $HOME/.local/{lib,share} $HOME/{.cache,.config}

# Go.
export GOPATH=$HOME/projects/go
test -d $GOPATH || mkdir -p $GOPATH
export PATH=$PATH:$GOPATH/bin

# file permissions: rwxr-xr-x
umask 022
