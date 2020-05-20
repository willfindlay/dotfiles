.PHONY: install
install: zsh tmux git

.PHONY: git
git:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .config/git/ $(HOME)/.config/git/

.PHONY: zsh
zsh:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .zshrc $(HOME)/.zshrc

.PHONY: tmux
tmux:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .tmux.conf $(HOME)/.tmux.conf
