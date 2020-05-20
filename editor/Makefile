.PHONY: install
install: vim vimrc vimskeletons

.PHONY: vim
vim:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .vim/ $(HOME)/.vim/

.PHONY: vimrc
vimrc:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .vimrc $(HOME)/.vimrc

.PHONY: vimskeletons
vimskeletons:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .vimskeletons/ $(HOME)/.vimskeletons/
