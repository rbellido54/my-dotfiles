-- config/keymaps.lua
-- Key mappings and bindings
-- Migrated from keys/mappings.vim

local opts = { noremap = true, silent = true }

-- Better nav for omnicomplete
vim.keymap.set("i", "<C-j>", "<C-n>", { expr = true, noremap = true })
vim.keymap.set("i", "<C-k>", "<C-p>", { expr = true, noremap = true })

-- Use alt + hjkl to resize windows
vim.keymap.set("n", "<M-j>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<M-k>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>", opts)

-- I hate escape more than anything else
vim.keymap.set("i", "jj", "<Esc>", opts)

-- TAB in general mode will move to text buffer
vim.keymap.set("n", "<TAB>", ":bnext<CR>", opts)
-- SHIFT-TAB will go back
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", opts)

-- Alternate way to save
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)
-- Alternate way to quit
vim.keymap.set("n", "<C-Q>", ":wq!<CR>", opts)
-- Use control-c instead of escape
vim.keymap.set("n", "<C-c>", "<Esc>", opts)
vim.keymap.set("i", "<C-c>", "<Esc>", opts)
-- <TAB>: completion.
vim.keymap.set("i", "<TAB>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<TAB>"
end, { expr = true, noremap = true })

-- Better tabbing
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Shortcut to add a line above or below cursor
vim.keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
vim.keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- FZF configuration
vim.g.fzf_action = {
  ["ctrl-t"] = "tab split",
  ["ctrl-x"] = "split",
  ["ctrl-v"] = "vsplit"
}

-- Enable per-command history
vim.g.fzf_history_dir = "~/.local/share/fzf-history"

-- FZF searching
vim.keymap.set("n", "<C-f>", ":Files<CR>", opts)

vim.g.fzf_tags_command = "ctags -R"

-- Border color and layout
vim.g.fzf_layout = {
  up = "~90%",
  window = {
    width = 0.8,
    height = 0.8,
    yoffset = 0.5,
    xoffset = 0.5,
    highlight = "Todo",
    border = "sharp"
  }
}

-- FZF environment options
vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --info=inline"
vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden"

-- Customize fzf colors to match your color scheme
vim.g.fzf_colors = {
  fg = {"fg", "Normal"},
  bg = {"bg", "Normal"},
  hl = {"fg", "Comment"},
  ["fg+"] = {"fg", "CursorLine", "CursorColumn", "Normal"},
  ["bg+"] = {"bg", "CursorLine", "CursorColumn"},
  ["hl+"] = {"fg", "Statement"},
  info = {"fg", "PreProc"},
  border = {"fg", "Ignore"},
  prompt = {"fg", "Conditional"},
  pointer = {"fg", "Exception"},
  marker = {"fg", "Keyword"},
  spinner = {"fg", "Label"},
  header = {"fg", "Comment"}
}

-- FZF Commands
-- Get Files
vim.cmd([[
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
]])

-- Get text in files with Rg
vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
]])

-- Ripgrep advanced
vim.cmd([[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = "rg --hidden --g '!.git' --column --line-number --no-heading --color=always --smart-case %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]])

-- Git grep
vim.cmd([[
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
]])

return {}