install:
	./stowsh -s -t "${HOME}" common || true

uninstall:
	./stowsh -s -D -t "${HOME}" common || true

reinstall: uninstall install

.PHONY: install uninstall reinstall
