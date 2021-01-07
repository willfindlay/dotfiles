.PHONY: install
install: pamenv config

.PHONY: pamenv
pamenv:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .pam_environment $(HOME)/.pam_environment

.PHONY: config
git: config
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .config $(HOME)/.config
