STOW=./common/.local/bin/stowage --exclude '.*.sw?' --exclude '.DS_Store' --exclude '*.orig' --exclude '*~'
PACKAGE=common

install:
	$(STOW) --target "${HOME}" $(PACKAGE)

uninstall:
	$(STOW) --uninstall --target "${HOME}" $(PACKAGE)

reinstall: uninstall install

.PHONY: install uninstall reinstall
