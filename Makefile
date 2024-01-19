.PHONY: all
all: apply-zshrc apply-nvim apply-tmux apply-envs apply-functions apply-fzf apply-path-exports apply-aliases apply-gitconfig

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
	@ln -s $(PWD)/.tmux.conf $(HOME)/.tmux.conf

.PHONY: apply-envs
apply-envs:
	@echo "Applying .envs.zsh"
	-@rm $(HOME)/.envs.zsh
	@ln -s $(PWD)/.envs.zsh $(HOME)/.envs.zsh

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

.PHONY: apply-gitconfig
apply-gitconfig:
	@echo "Applying .gitconfig"
	-@rm $(HOME)/.gitconfig
	@ln -s $(PWD)/.gitconfig $(HOME)/.gitconfig

