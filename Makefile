.PHONY: all
all: apply-zshrc apply-nvim apply-tmux apply-functions apply-fzf apply-path-exports apply-aliases

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

.PHONY: apply-wezterm
apply-wezterm:
	@echo "Applying wezterm config"
	-@rm -rf $(HOME)/.config/wezterm
	@ln -s $(PWD)/wezterm $(HOME)/.config/

.PHONY: apply-zellij
apply-zellij:
	@echo "Applying zellij"
	-@rm -rf $(HOME)/.config/zellij
	@ln -s $(PWD)/zellij $(HOME)/.config/

.PHONY: apply-tmux
apply-tmux:
	@echo "Applying .tmux.conf"
	-@rm $(HOME)/.tmux.conf && ln -s $(PWD)/.tmux.conf $(HOME)/.tmux.conf
	@echo "Applying .tmux.conf.local"
	-@rm $(HOME)/.tmux.conf.local && ln -s $(PWD)/.tmux.conf.local $(HOME)/.tmux.conf.local

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
	-@rm $(HOME)/.config/.starship.toml
	@ln -s $(PWD)/.starship.toml $(HOME)/.config/.starship.toml

.PHONY: create-gitconfig
create-gitconfig:
	@echo "Creating .gitconfig"
	@cp $(PWD)/.gitconfig $(HOME)/.gitconfig

