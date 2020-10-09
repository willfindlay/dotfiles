.PHONY: install
install: general xprofile

.PHONY: general
general:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .config/ $(HOME)/.config/

.PHONY: xprofile
xprofile:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .xbindkeysrc $(HOME)/.xbindkeysrc
