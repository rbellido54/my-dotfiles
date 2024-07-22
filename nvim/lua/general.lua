require("utils")
require("plug-colorizer")
require("plug-config")
require("lsp-config")
require("mappings")

-- Disable some built-in plugins
local disabled_built_ins = {
	"netrwPlugin",
	"tohtml",
	"man",
	"tarPlugin",
	"zipPlugin",
	"gzip",
}

-- Show tabs and trailing spaces
vim.opt.list = true
vim.opt.listchars:append("tab:▸ ")
vim.opt.listchars:append("trail:·")

for i = 1, table.maxn(disabled_built_ins) do
	vim.g["loaded_" .. disabled_built_ins[i]] = 1
end
