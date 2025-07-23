-- config/keymaps/git.lua
-- Git integration keymaps for fugitive, signify, and lazygit
-- These keymaps provide comprehensive Git workflow support

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Check if specific Git plugins are available
local function check_git_plugins()
  local plugins = {
    fugitive = pcall(require, "vim-fugitive") or vim.fn.exists(":Git") == 2,
    signify = pcall(require, "vim-signify") or vim.fn.exists(":SignifyToggle") == 2,
    lazygit = pcall(require, "lazygit") or vim.fn.exists(":LazyGit") == 2,
  }
  return plugins
end

-- Setup function
function M.setup()
  local wk_helper = get_wk_helper()
  local git_plugins = check_git_plugins()
  
  -- Define Git keymaps with descriptions
  local git_mappings = {}
  
  -- Core Git operations (fugitive)
  if git_plugins.fugitive then
    local fugitive_mappings = {
      -- Git status and basic operations
      { "<leader>gs", "<cmd>Git<CR>", desc = "Git status", mode = "n" },
      { "<leader>ga", "<cmd>Git add .<CR>", desc = "Git add all", mode = "n" },
      { "<leader>gA", "<cmd>Git add %<CR>", desc = "Git add current file", mode = "n" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit", mode = "n" },
      { "<leader>gC", "<cmd>Git commit --amend<CR>", desc = "Git commit amend", mode = "n" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push", mode = "n" },
      { "<leader>gP", "<cmd>Git pull<CR>", desc = "Git pull", mode = "n" },
      { "<leader>gf", "<cmd>Git fetch<CR>", desc = "Git fetch", mode = "n" },
      
      -- Git diff operations
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split", mode = "n" },
      { "<leader>gD", "<cmd>Gdiffsplit HEAD<CR>", desc = "Git diff HEAD", mode = "n" },
      { "<leader>gv", "<cmd>Gvdiffsplit<CR>", desc = "Git vertical diff", mode = "n" },
      
      -- Git blame and history
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame", mode = "n" },
      { "<leader>gl", "<cmd>Git log<CR>", desc = "Git log", mode = "n" },
      { "<leader>gL", "<cmd>Git log --oneline<CR>", desc = "Git log oneline", mode = "n" },
      
      -- Git branch operations
      { "<leader>gB", "<cmd>Git branch<CR>", desc = "Git branches", mode = "n" },
      { "<leader>go", "<cmd>Git checkout<CR>", desc = "Git checkout", mode = "n" },
      { "<leader>gO", "<cmd>Git checkout -b ", desc = "Git checkout new branch", mode = "n", silent = false },
      
      -- Git stash operations
      { "<leader>gS", "<cmd>Git stash<CR>", desc = "Git stash", mode = "n" },
      { "<leader>gu", "<cmd>Git stash pop<CR>", desc = "Git stash pop", mode = "n" },
      { "<leader>gU", "<cmd>Git stash list<CR>", desc = "Git stash list", mode = "n" },
      
      -- Git merge and rebase
      { "<leader>gm", "<cmd>Git merge<CR>", desc = "Git merge", mode = "n" },
      { "<leader>gr", "<cmd>Git rebase<CR>", desc = "Git rebase", mode = "n" },
      { "<leader>gR", "<cmd>Git rebase -i<CR>", desc = "Git rebase interactive", mode = "n" },
      
      -- Git search
      { "<leader>gg", "<cmd>GGrep<CR>", desc = "Git grep", mode = "n" },
      { "<leader>gG", "<cmd>GGrep <C-r><C-w><CR>", desc = "Git grep word under cursor", mode = "n" },
      
      -- Git file operations
      { "<leader>gw", "<cmd>Gwrite<CR>", desc = "Git write (stage file)", mode = "n" },
      { "<leader>ge", "<cmd>Gedit<CR>", desc = "Git edit", mode = "n" },
      { "<leader>gx", "<cmd>Gremove<CR>", desc = "Git remove file", mode = "n" },
      { "<leader>gM", "<cmd>Gmove ", desc = "Git move/rename file", mode = "n", silent = false },
    }
    
    -- Add fugitive mappings to the main list
    for _, mapping in ipairs(fugitive_mappings) do
      table.insert(git_mappings, mapping)
    end
  end
  
  -- Git hunk operations (signify)
  if git_plugins.signify then
    local signify_mappings = {
      -- Hunk navigation
      { "<leader>gj", "<plug>(signify-next-hunk)", desc = "Next Git hunk", mode = "n" },
      { "<leader>gk", "<plug>(signify-prev-hunk)", desc = "Previous Git hunk", mode = "n" },
      { "]h", "<plug>(signify-next-hunk)", desc = "Next Git hunk", mode = "n" },
      { "[h", "<plug>(signify-prev-hunk)", desc = "Previous Git hunk", mode = "n" },
      
      -- Hunk operations
      { "<leader>gh", "<cmd>SignifyHunkDiff<CR>", desc = "Show hunk diff", mode = "n" },
      { "<leader>gH", "<cmd>SignifyHunkUndo<CR>", desc = "Undo hunk", mode = "n" },
      
      -- Signify toggle
      { "<leader>gt", "<cmd>SignifyToggle<CR>", desc = "Toggle Git signs", mode = "n" },
      { "<leader>gT", "<cmd>SignifyToggleHighlight<CR>", desc = "Toggle Git sign highlights", mode = "n" },
      
      -- Signify refresh
      { "<leader>gF", "<cmd>SignifyRefresh<CR>", desc = "Refresh Git signs", mode = "n" },
    }
    
    -- Add signify mappings to the main list
    for _, mapping in ipairs(signify_mappings) do
      table.insert(git_mappings, mapping)
    end
  end
  
  -- LazyGit integration
  if git_plugins.lazygit then
    local lazygit_mappings = {
      { "<leader>lg", "<cmd>LazyGit<CR>", desc = "LazyGit", mode = "n" },
      { "<leader>lf", "<cmd>LazyGitFilter<CR>", desc = "LazyGit file history", mode = "n" },
      { "<leader>lc", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "LazyGit current file history", mode = "n" },
    }
    
    -- Add lazygit mappings to the main list
    for _, mapping in ipairs(lazygit_mappings) do
      table.insert(git_mappings, mapping)
    end
  end
  
  -- Additional Git workflow keymaps
  local workflow_mappings = {
    -- Quick commit and push
    { "<leader>gq", function()
        local msg = vim.fn.input("Commit message: ")
        if msg ~= "" then
          vim.cmd("Git add .")
          vim.cmd("Git commit -m '" .. msg .. "'")
        end
      end, 
      desc = "Quick commit all", 
      mode = "n" 
    },
    
    { "<leader>gQ", function()
        local msg = vim.fn.input("Commit message: ")
        if msg ~= "" then
          vim.cmd("Git add .")
          vim.cmd("Git commit -m '" .. msg .. "'")
          vim.cmd("Git push")
        end
      end, 
      desc = "Quick commit and push", 
      mode = "n" 
    },
    
    -- Git status shortcuts
    { "<leader>g?", function()
        print("Git keymaps available:")
        print("  gs - Git status    ga - Add all     gc - Commit")
        print("  gp - Push         gP - Pull        gd - Diff")
        print("  gb - Blame        gl - Log         lg - LazyGit")
        print("  gj/gk - Next/Prev hunk           gt - Toggle signs")
      end, 
      desc = "Show Git keymap help", 
      mode = "n" 
    },
  }
  
  -- Add workflow mappings to the main list
  for _, mapping in ipairs(workflow_mappings) do
    table.insert(git_mappings, mapping)
  end
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(git_mappings) do
    if mapping[1] and mapping[2] then
      local modes = mapping.mode or "n"
      local opts = {
        desc = mapping.desc,
        noremap = mapping.noremap ~= false,
        silent = mapping.silent ~= false,
        expr = mapping.expr,
      }
      vim.keymap.set(modes, mapping[1], mapping[2], opts)
    end
  end
  
  -- Also register with which-key for better help display
  if wk_helper then
    wk_helper.add_keymaps(git_mappings)
  end
  
  -- Set up Git-specific autocommands
  local git_augroup = vim.api.nvim_create_augroup("GitKeymaps", { clear = true })
  
  -- Auto-refresh signify when entering buffer
  if git_plugins.signify then
    vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
      group = git_augroup,
      pattern = "*",
      command = "silent! SignifyRefresh",
    })
  end
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  fugitive_core = { "<leader>gs", "<leader>ga", "<leader>gc", "<leader>gp" },
  fugitive_diff = { "<leader>gd", "<leader>gv", "<leader>gb" },
  fugitive_branch = { "<leader>gB", "<leader>go", "<leader>gO" },
  fugitive_stash = { "<leader>gS", "<leader>gu", "<leader>gU" },
  signify_nav = { "<leader>gj", "<leader>gk", "]h", "[h" },
  signify_ops = { "<leader>gh", "<leader>gH", "<leader>gt" },
  lazygit = { "<leader>lg", "<leader>lf", "<leader>lc" },
  workflow = { "<leader>gq", "<leader>gQ", "<leader>g?" },
}

return M