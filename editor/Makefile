.PHONY: install
install: nvim vimskeletons

.PHONY: nvim
nvim:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .config/nvim/ $(HOME)/.config/nvim/

.PHONY: vimskeletons
vimskeletons:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .vimskeletons/ $(HOME)/.vimskeletons/
