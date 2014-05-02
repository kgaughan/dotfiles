mkdir -p $HOME/.local/{lib,share} $HOME/{.cache,.config}

# Go.

export GOPATH=$HOME/Projects/go
mkdir -p $GOPATH
export PATH=$PATH:$GOPATH/bin

# file permissions: rwxr-xr-x
umask 022
