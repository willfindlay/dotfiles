.PHONY: msg
msg:
	@echo "Please see Makefile for targets"

.PHONY: install
install: | bin editor env gui shell

.PHONY: bin
bin:
	$(MAKE) -C bin

.PHONY: editor
editor:
	$(MAKE) -C editor

.PHONY: env
env:
	$(MAKE) -C env

.PHONY: gui
gui:
	$(MAKE) -C gui

.PHONY: shell
shell:
	$(MAKE) -C shell
