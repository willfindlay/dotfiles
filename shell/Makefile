.PHONY: install
install: zsh tmux git

.PHONY: git
git:
	rsync -a .config/git/ $(HOME)/.config/git/

.PHONY: zsh
zsh:
	rsync -a .zshrc $(HOME)/.zshrc
	rsync -a .zsh-syntax-highlighting.zsh $(HOME)/.zsh-syntax-highlighting.zsh

.PHONY: tmux
tmux:
	rsync -a .tmux.conf $(HOME)/.tmux.conf
