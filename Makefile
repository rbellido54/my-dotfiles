.PHONY apply-zshrc
apply-zshrc:
	@echo "Applying zshrc"
	@ln -s $(PWD)/.zshrc $(HOME)/.zshrc

.PHONY apply-nvim
apply-nvim:
	@echo "Applying nvim"
	@ln -s $(PWD)/nvim $(HOME)/.config/

.PHONY apply-tmux
apply-tmux:
		@echo "Applying tmux"
		@ln -s $(PWD)/.tmux.conf $(HOME)/.tmux.conf
