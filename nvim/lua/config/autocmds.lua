-- config/autocmds.lua
-- Auto commands
-- Extracted from general/settings.vim

-- Create an augroup for configuration-related autocommands
local config_group = vim.api.nvim_create_augroup("ConfigAutoCommands", { clear = true })

-- Auto source when writing to init.vim/init.lua
-- Equivalent to: au! BufWritePost $MYVIMRC source %
vim.api.nvim_create_autocmd("BufWritePost", {
  group = config_group,
  pattern = vim.fn.expand("$MYVIMRC"),
  callback = function()
    vim.cmd("source %")
    vim.notify("Reloaded " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
  end,
  desc = "Auto source configuration file on save"
})

-- Note: The following autocmd is commented out in the original
-- It would change the local working directory automatically, except when it's /tmp
-- If you want to enable it, uncomment the following:
--[[
vim.api.nvim_create_autocmd("BufEnter", {
  group = config_group,
  pattern = "*",
  callback = function()
    local path = vim.fn.expand("%:p:h")
    if not path:match("^/tmp") then
      vim.cmd("silent! lcd " .. path)
    end
  end,
  desc = "Change local working directory to file's directory"
})
--]]

return {}