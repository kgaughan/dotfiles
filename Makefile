STOW=./common/.local/bin/stowage --exclude '.*.sw?' --exclude '.DS_Store'
PACKAGE=common

install:
	$(STOW) -t "${HOME}" $(PACKAGE)

uninstall:
	$(STOW) -D -t "${HOME}" $(PACKAGE)

reinstall: uninstall install

.PHONY: install uninstall reinstall
