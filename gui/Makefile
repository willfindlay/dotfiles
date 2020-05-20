.PHONY: install
install: general xprofile

.PHONY: general
general:
	rsync -a .config/ $(HOME)/.config/

.PHONY: xprofile
xprofile:
	rsync -a .screenlayout/ $(HOME)/.screenlayout/
	rsync -a .xprofile $(HOME)/.xprofile
	rsync -a .xbindkeysrc $(HOME)/.xbindkeysrc
