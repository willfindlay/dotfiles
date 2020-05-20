.PHONY: install
install: localbin

.PHONY: localbin
localbin:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .local/ $(HOME)/.local/
