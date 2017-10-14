STOW=./common/.local/bin/stowage --exclude '.*.sw?' \
				 --exclude '.DS_Store'

install:
	$(STOW) -t "${HOME}" common

uninstall:
	$(STOW) -D -t "${HOME}" common

reinstall: uninstall install

.PHONY: install uninstall reinstall
