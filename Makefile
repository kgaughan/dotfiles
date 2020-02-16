STOW=./common/.local/bin/stowage --exclude '.*.sw?' --exclude '.DS_Store' --exclude '*.orig' --exclude '*~'
PACKAGE=common

install:
	$(STOW) -t "${HOME}" $(PACKAGE)

uninstall:
	$(STOW) -D -t "${HOME}" $(PACKAGE)

fetch-fisher:
	curl https://raw.githubusercontent.com/jorgebucaran/fisher/master/fisher.fish -o common/.config/fish/functions/fisher.fish

reinstall: uninstall install

.PHONY: install uninstall reinstall
.PHONY: fetch-fisher
