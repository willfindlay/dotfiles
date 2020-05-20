.PHONY: install
install: pamenv

.PHONY: pamenv
pamenv:
	rsync -ab --backup-dir=$(shell readlink -f ../backups/) .pam_environment $(HOME)/.pam_environment
