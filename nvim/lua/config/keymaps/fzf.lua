-- config/keymaps/fzf.lua
-- FZF fuzzy finder keymaps and configuration
-- Provides comprehensive fuzzy finding capabilities for files, buffers, and content

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Check if FZF is available
local function check_fzf_available()
  return vim.fn.exists(":Files") == 2 or vim.fn.exists("*fzf#run") == 1
end

-- Setup FZF configuration
local function setup_fzf_config()
  -- FZF action configuration
  vim.g.fzf_action = {
    ["ctrl-t"] = "tab split",
    ["ctrl-x"] = "split",
    ["ctrl-v"] = "vsplit"
  }
  
  -- FZF history directory
  vim.g.fzf_history_dir = "~/.local/share/fzf-history"
  
  -- FZF tags command
  vim.g.fzf_tags_command = "ctags -R"
  
  -- FZF layout configuration (matching legacy config)
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
  
  -- FZF colors to match color scheme
  vim.g.fzf_colors = {
    fg = { "fg", "Normal" },
    bg = { "bg", "Normal" },
    hl = { "fg", "Comment" },
    ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
    ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
    ["hl+"] = { "fg", "Statement" },
    info = { "fg", "PreProc" },
    border = { "fg", "Ignore" },
    prompt = { "fg", "Conditional" },
    pointer = { "fg", "Exception" },
    marker = { "fg", "Keyword" },
    spinner = { "fg", "Label" },
    header = { "fg", "Comment" }
  }
end

-- Create custom FZF commands
local function setup_fzf_commands()
  -- Enhanced Files command with preview
  vim.cmd([[
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
  ]])
  
  -- Enhanced Rg command with preview
  vim.cmd([[
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)
  ]])
  
  -- Custom RipgrepFzf function (matching legacy config)
  vim.cmd([[
    function! RipgrepFzf(query, fullscreen)
      let command_fmt = "rg --hidden --g '!.git' --column --line-number --no-heading --color=always --smart-case %s || true"
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
  ]])
  
  -- RG command using RipgrepFzf
  vim.cmd([[
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
  ]])
  
  -- Git grep command
  vim.cmd([[
    command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
  ]])
end

-- Setup function
function M.setup()
  if not check_fzf_available() then
    vim.notify("FZF not available, skipping FZF keymaps", vim.log.levels.WARN)
    return false
  end
  
  local wk_helper = get_wk_helper()
  
  -- Setup FZF configuration
  setup_fzf_config()
  setup_fzf_commands()
  
  -- Define FZF keymaps with descriptions
  local fzf_mappings = {
    -- File finding
    { "<C-f>", "<cmd>Files<CR>", desc = "Find files", mode = "n" },
    { "<leader>f", "<cmd>Files<CR>", desc = "Find files", mode = "n" },
    { "<leader>F", "<cmd>Files ~<CR>", desc = "Find files from home", mode = "n" },
    
    -- Buffer management
    { "<leader>b", "<cmd>Buffers<CR>", desc = "Find buffers", mode = "n" },
    { "<leader>bl", "<cmd>BLines<CR>", desc = "Search lines in current buffer", mode = "n" },
    { "<leader>bL", "<cmd>Lines<CR>", desc = "Search lines in all buffers", mode = "n" },
    
    -- Content searching
    { "<leader>g", "<cmd>Rg<CR>", desc = "RipGrep search", mode = "n" },
    { "<leader>G", "<cmd>RG<CR>", desc = "RipGrep interactive", mode = "n" },
    { "<leader>gs", "<cmd>Ag<CR>", desc = "Silver Searcher", mode = "n" },
    { "<leader>gw", "<cmd>Rg <C-r><C-w><CR>", desc = "Search word under cursor", mode = "n" },
    { "<leader>gW", "<cmd>RG <C-r><C-w><CR>", desc = "Search word interactive", mode = "n" },
    
    -- Command and history
    { "<leader>c", "<cmd>Commands<CR>", desc = "Find commands", mode = "n" },
    { "<leader>:", "<cmd>History:<CR>", desc = "Command history", mode = "n" },
    { "<leader>/", "<cmd>History/<CR>", desc = "Search history", mode = "n" },
    
    -- Tags and marks
    { "<leader>t", "<cmd>Tags<CR>", desc = "Find tags", mode = "n" },
    { "<leader>T", "<cmd>BTags<CR>", desc = "Find buffer tags", mode = "n" },
    { "<leader>m", "<cmd>Marks<CR>", desc = "Find marks", mode = "n" },
    
    -- Git integration
    { "<leader>gf", "<cmd>GFiles<CR>", desc = "Git files", mode = "n" },
    { "<leader>gF", "<cmd>GFiles?<CR>", desc = "Git status files", mode = "n" },
    { "<leader>gc", "<cmd>Commits<CR>", desc = "Git commits", mode = "n" },
    { "<leader>gC", "<cmd>BCommits<CR>", desc = "Buffer Git commits", mode = "n" },
    
    -- Vim/Neovim specific
    { "<leader>h", "<cmd>Helptags<CR>", desc = "Help tags", mode = "n" },
    { "<leader>th", "<cmd>Colors<CR>", desc = "Color schemes", mode = "n" },
    { "<leader>k", "<cmd>Maps<CR>", desc = "Normal mode keymaps", mode = "n" },
    { "<leader>K", "<cmd>Maps!<CR>", desc = "Insert mode keymaps", mode = "n" },
    
    -- Window and location
    { "<leader>w", "<cmd>Windows<CR>", desc = "Find windows", mode = "n" },
    { "<leader>j", "<cmd>Jumps<CR>", desc = "Jump list", mode = "n" },
    { "<leader>L", "<cmd>Locate ", desc = "Locate files", mode = "n", silent = false },
    
    -- Snippets (if available)
    { "<leader>s", "<cmd>Snippets<CR>", desc = "Find snippets", mode = "n" },
    
    -- File types and syntax
    { "<leader>ft", "<cmd>Filetypes<CR>", desc = "File types", mode = "n" },
    
    -- Advanced searches
    { "<leader>r", function()
        local word = vim.fn.expand("<cword>")
        vim.cmd("Rg " .. word)
      end, 
      desc = "Search current word", 
      mode = "n" 
    },
    
    { "<leader>R", function()
        local word = vim.fn.input("Search for: ", vim.fn.expand("<cword>"))
        if word ~= "" then
          vim.cmd("Rg " .. word)
        end
      end, 
      desc = "Search with input", 
      mode = "n" 
    },
    
    -- Directory-specific searches
    { "<leader>fd", function()
        local dir = vim.fn.input("Directory: ", "", "dir")
        if dir ~= "" then
          vim.cmd("Files " .. dir)
        end
      end, 
      desc = "Find files in directory", 
      mode = "n" 
    },
    
    -- Project root search
    { "<leader>fp", function()
        local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if root and root ~= "" then
          vim.cmd("Files " .. root)
        else
          vim.cmd("Files")
        end
      end, 
      desc = "Find files in project root", 
      mode = "n" 
    },
    
    -- Help for FZF commands
    { "<leader>?", function()
        print("FZF keymaps available:")
        print("  <C-f>/f - Files     b - Buffers    g/G - RipGrep")
        print("  c - Commands       t - Tags       m - Marks")
        print("  h - Help tags      k - Keymaps    w - Windows")
        print("  gf - Git files     gc - Commits   r/R - Search word")
      end, 
      desc = "Show FZF keymap help", 
      mode = "n" 
    },
  }
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(fzf_mappings) do
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
    wk_helper.add_keymaps(fzf_mappings)
  end
  
  -- Set up FZF-specific autocommands
  local fzf_augroup = vim.api.nvim_create_augroup("FzfKeymaps", { clear = true })
  
  -- Better FZF window handling
  vim.api.nvim_create_autocmd("FileType", {
    group = fzf_augroup,
    pattern = "fzf",
    callback = function()
      -- Disable line numbers in FZF buffer
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      
      -- Set up FZF-specific keymaps
      vim.keymap.set("t", "<Esc>", "<C-c>", { buffer = true, noremap = true })
      vim.keymap.set("t", "<C-j>", "<Down>", { buffer = true, noremap = true })
      vim.keymap.set("t", "<C-k>", "<Up>", { buffer = true, noremap = true })
    end,
  })
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  file_finding = { "<C-f>", "<leader>f", "<leader>F" },
  buffer_ops = { "<leader>b", "<leader>bl", "<leader>bL" },
  content_search = { "<leader>g", "<leader>G", "<leader>gw" },
  commands = { "<leader>c", "<leader>:", "<leader>/" },
  tags_marks = { "<leader>t", "<leader>T", "<leader>m" },
  git_integration = { "<leader>gf", "<leader>gc", "<leader>gC" },
  vim_specific = { "<leader>h", "<leader>th", "<leader>k" },
  advanced = { "<leader>r", "<leader>R", "<leader>fd", "<leader>fp" },
}

return M