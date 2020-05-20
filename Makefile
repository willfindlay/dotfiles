.PHONY: all
all:
	@echo "Please run make install"

.PHONY: install
install:
	$(MAKE) -C bin
	$(MAKE) -C editor
	$(MAKE) -C env
	$(MAKE) -C gui
	$(MAKE) -C shell
