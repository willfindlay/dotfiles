.PHONY: install
install: picom

.PHONY: picom
picom:
	sudo rsync -ab --backup-dir=$(shell readlink -f ../backups/) ./xdg /etc/xdg
