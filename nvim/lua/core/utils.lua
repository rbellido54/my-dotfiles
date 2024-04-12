local function cmd(command)
  return table.concat({ '<Cmd>', command, '<CR>' })
end

local function set_keymap(...)
  vim.api.nvim_set_keymap(...)
end
