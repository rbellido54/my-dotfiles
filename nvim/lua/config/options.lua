-- config/options.lua
-- Vim options and settings
-- Migrated from general/settings.vim

-- Set leader key
vim.g.mapleader = " "

-- Syntax and display options
vim.cmd("syntax enable")                   -- Enable syntax highlighting
vim.opt.hidden = true                      -- Required to keep multiple buffers open
vim.opt.wrap = false                       -- Display long lines as just one line
vim.opt.encoding = "utf-8"                 -- The encoding displayed
vim.opt.pumheight = 10                     -- Makes popup menu smaller
vim.opt.fileencoding = "utf-8"             -- The encoding written to file
vim.opt.ruler = true                       -- Show the cursor position all the time
vim.opt.cmdheight = 2                      -- More space for displaying messages
vim.opt.iskeyword:append("-")              -- Treat dash separated words as a word text object
vim.opt.mouse = "a"                        -- Enable your mouse
vim.opt.splitbelow = true                  -- Horizontal splits will automatically be below
vim.opt.splitright = true                  -- Vertical splits will automatically be to the right
-- vim.opt.t_Co = 256                      -- Support 256 colors (Vim only, not needed in Neovim)
vim.opt.conceallevel = 0                   -- So that I can see `` in markdown files

-- Indentation options
vim.opt.tabstop = 2                        -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2                     -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true                    -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true                   -- Converts tabs to spaces
vim.opt.smartindent = true                 -- Makes indenting smart
vim.opt.autoindent = true                  -- Good auto indent

-- UI options
vim.opt.laststatus = 0                     -- Always display the status line
vim.opt.number = true                      -- Line numbers
vim.opt.relativenumber = true              -- Relative line numbers
vim.opt.cursorline = true                  -- Enable highlighting of the current line
vim.opt.background = "dark"                -- Tell vim what the background color looks like
vim.opt.showtabline = 2                    -- Always show tabs
vim.opt.showmode = false                   -- We don't need to see things like -- INSERT -- anymore

-- Backup and swap options
vim.opt.backup = false                     -- This is recommended by coc
vim.opt.writebackup = false                -- This is recommended by coc
vim.opt.swapfile = false                   -- Turn off swap file

-- Performance and behavior options
vim.opt.updatetime = 300                   -- Faster completion
vim.opt.timeoutlen = 500                   -- By default timeoutlen is 1000 ms
vim.opt.formatoptions = "cro"              -- Stop newline continuation of comments
vim.opt.clipboard = "unnamedplus"          -- Copy paste between vim and everything else

-- Autocommands
vim.cmd([[
  augroup autosource_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source %
  augroup END
]])

-- Command mappings
vim.cmd("cmap w!! w !sudo tee %")

-- Note: The following autocmd is commented out in the original
-- vim.cmd([[
--   autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
-- ]])

return {}