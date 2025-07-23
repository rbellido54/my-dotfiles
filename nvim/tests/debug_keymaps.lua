-- Debug script to see what keymaps are actually set

-- Load config
require('config')

-- Wait a bit for keymaps to be set
vim.wait(100)

-- Print all normal mode keymaps
print("\n=== Normal mode keymaps ===")
local n_keymaps = vim.api.nvim_get_keymap('n')
for _, km in ipairs(n_keymaps) do
  if km.lhs:match("<C%-") or km.lhs:match("<Space>") or km.lhs:match("<Tab>") or km.lhs:match("<S%-Tab>") then
    print(string.format("  %s -> %s", km.lhs, km.rhs or km.callback and "<function>" or "?"))
  end
end

-- Print all insert mode keymaps
print("\n=== Insert mode keymaps ===")
local i_keymaps = vim.api.nvim_get_keymap('i')
for _, km in ipairs(i_keymaps) do
  if km.lhs == "jj" or km.lhs:match("<C%-") or km.lhs == "<Tab>" then
    print(string.format("  %s -> %s", km.lhs, km.rhs or km.callback and "<function>" or "?"))
  end
end

-- Print all visual mode keymaps
print("\n=== Visual mode keymaps ===")
local v_keymaps = vim.api.nvim_get_keymap('v')
for _, km in ipairs(v_keymaps) do
  -- Show all visual mode mappings to debug
  print(string.format("  %s -> %s", km.lhs, km.rhs or km.callback and "<function>" or "?"))
end

-- Check leader key
print("\n=== Leader key ===")
print("  vim.g.mapleader =", vim.inspect(vim.g.mapleader))

-- Check for leader mappings
print("\n=== Leader mappings in normal mode ===")
local n_keymaps = vim.api.nvim_get_keymap('n')
for _, km in ipairs(n_keymaps) do
  if km.lhs:match("^ ") then  -- Space at the beginning
    print(string.format("  %s -> %s", vim.inspect(km.lhs), km.rhs or km.callback and "<function>" or "?"))
  end
end

-- Check FZF variables
print("\n=== FZF Configuration ===")
print("  fzf_action:", vim.inspect(vim.g.fzf_action))
print("  fzf_history_dir:", vim.g.fzf_history_dir)
print("  FZF_DEFAULT_OPTS:", vim.env.FZF_DEFAULT_OPTS)
print("  FZF_DEFAULT_COMMAND:", vim.env.FZF_DEFAULT_COMMAND)