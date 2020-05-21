.PHONY: install
install: zsh tmux git

.PHONY: git
git:
	@echo "WARNING: .config/git/config sets a few variables you WILL want to change,"
	@echo "         as they are specific to my personal configuration."
	@echo
	@echo "In particular, please consider making the following changes:"
	@diff -u .config/git/config .config/git/clean-config
	@echo "Alternatively, replace .config/git/config with .config/git/clean-config"
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .config/git/ $(HOME)/.config/git/

.PHONY: zsh
zsh:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .zshrc $(HOME)/.zshrc

.PHONY: tmux
tmux:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .tmux.conf $(HOME)/.tmux.conf
