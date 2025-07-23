-- init.lua
-- Modern Neovim configuration entry point
-- Migrated from init.vim while preserving all functionality

-- Load vim-plug and plugins
vim.cmd("source $HOME/.config/nvim/vim-plug/plugins.vim")

-- Load our new Lua configuration modules
require("config")

-- Load theme configuration
-- Choose themes by uncommenting/commenting:
-- vim.cmd("source $HOME/.config/nvim/themes/onedark.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/base16.vim") 
-- vim.cmd("source $HOME/.config/nvim/themes/gruvbox.vim")
vim.cmd("source $HOME/.config/nvim/themes/nightfox.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/deus.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/everforest.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/tokyonight.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/kanagawa.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/oceanic-next.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/catpuccin.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/neon.vim")
-- vim.cmd("source $HOME/.config/nvim/themes/paper.vim")

-- Alternative colorschemes (commented out from original)
-- vim.cmd("colorscheme eldritch")
-- vim.cmd("colorscheme terafox")

-- Load airline configuration
vim.cmd("source $HOME/.config/nvim/themes/airline.vim")

-- Include all plugin configurations
-- This preserves the existing plugin config loading from init.vim
vim.cmd([[
for f in split(glob($HOME . "/.config/nvim/plug-config/*.vim"), '\n')
  exe 'source' f
endfor
]])

-- Load additional Lua modules (preserving the original require)
require("general")

-- Notification that new init.lua is active
vim.notify("Neovim loaded with modern Lua configuration", vim.log.levels.INFO)