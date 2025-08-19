.PHONY: apply-all
apply-all: run-pre-install apply-zshrc apply-nvim apply-tmux apply-functions apply-fzf apply-path-exports apply-aliases apply-starship run-post-install

.PHONY: apply-zshrc
apply-zshrc:
	@echo "Applying .zshrc"
	-@rm $(HOME)/.zshrc
	@ln -s $(PWD)/.zshrc $(HOME)/.zshrc

.PHONY: apply-nvim
apply-nvim:
	@echo "Applying nvim"
	-@rm -rf $(HOME)/.config/nvim
	@ln -s $(PWD)/nvim $(HOME)/.config/

.PHONY: apply-tmux
apply-tmux:
	@echo "Applying .tmux.conf"
	-@rm $(HOME)/.tmux.conf
	ln -s $(PWD)/.tmux.conf $(HOME)/.tmux.conf
	@echo "Applying .tmux.conf.local"
	-@rm $(HOME)/.tmux.conf.local
	ln -s $(PWD)/.tmux.conf.local $(HOME)/.tmux.conf.local

.PHONY: create-envs
create-envs:
	@echo "Creating .envs.zsh"
	@cp $(PWD)/.envs.zsh $(HOME)/.envs.zsh

.PHONY: apply-functions
apply-functions:
	@echo "Applying .functions.zsh"
	-@rm $(HOME)/.functions.zsh
	@ln -s $(PWD)/.functions.zsh $(HOME)/.functions.zsh

.PHONY: apply-fzf
apply-fzf:
	@echo "Applying .fzf.zsh"
	-@rm $(HOME)/.fzf.zsh
	@ln -s $(PWD)/.fzf.zsh $(HOME)/.fzf.zsh

.PHONY: apply-path-exports
apply-path-exports:
	@echo "Applying .path-exports.zsh"
	-@rm $(HOME)/.path-exports.zsh
	@ln -s $(PWD)/.path-exports.zsh $(HOME)/.path-exports.zsh

.PHONY: apply-aliases
apply-aliases:
	@echo "Applying .aliases.zsh"
	-@rm $(HOME)/.aliases.zsh
	@ln -s $(PWD)/.aliases.zsh $(HOME)/.aliases.zsh

.PHONY: apply-starship
apply-starship:
	@echo "Applying .starship.toml"
	-@rm $(HOME)/.config/starship.toml
	@ln -s $(PWD)/starship.toml $(HOME)/.config/starship.toml

.PHONY: create-gitconfig
create-gitconfig:
	@echo "Creating .gitconfig"
	@cp $(PWD)/.gitconfig $(HOME)/.gitconfig

.PHONY: run-pre-install
run-pre-install:
	@echo "Running pre-install script"
	@chmod +x $(CURDIR)/pre-install.sh
	sh $(CURDIR)/pre-install.sh

.PHONY: run-post-install
run-post-install:
	@echo "Running post-install script"
	@chmod +x $(CURDIR)/post-install.sh
	sh $(CURDIR)/post-install.sh

.PHONY: lazygit-config-arch
lazygit-config-arch:
	@echo "Applying lazygit config for Arch Linux"
	@ln -s $(PWD)/lazygit $(HOME)/.config

.PHONY: lazygit-config-mac
lazygit-config-mac:
	@echo "Applying lazygit config for Mac OS"
	@ln -s $(PWD)/lazygit $(HOME)/Library/Application\ Support/
