.PHONY: install
install: vim vimrc vimskeletons

.PHONY: vim
vim:
	rsync -a .vim/ $(HOME)/.vim/

.PHONY: vimrc
vimrc:
	rsync -a .vimrc $(HOME)/.vimrc

.PHONY: vimskeletons
vimskeletons:
	rsync -a .vimskeletons/ $(HOME)/.vimskeletons/
