-- config/keymaps/terminal.lua
-- Terminal management keymaps
-- Provides comprehensive terminal integration with floaterm and native terminals

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Check if terminal plugins are available
local function check_terminal_plugins()
  local plugins = {
    floaterm = vim.fn.exists(":FloatermToggle") == 2 or pcall(require, "vim-floaterm"),
    native_terminal = vim.fn.has("nvim") == 1,
  }
  return plugins
end

-- Setup floaterm configuration
local function setup_floaterm_config()
  -- Floaterm appearance
  vim.g.floaterm_width = 0.9
  vim.g.floaterm_height = 0.9
  vim.g.floaterm_position = "center"
  vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
  vim.g.floaterm_title = "Terminal ($1/$2)"
  
  -- Floaterm behavior
  vim.g.floaterm_autoinsert = 1
  vim.g.floaterm_autoclose = 1
  vim.g.floaterm_gitcommit = "floaterm"
  vim.g.floaterm_wintitle = 0
  
  -- Function key mappings (global)
  vim.g.floaterm_keymap_toggle = "<F12>"
  vim.g.floaterm_keymap_new = "<F10>"
  vim.g.floaterm_keymap_kill = "<F8>"
  vim.g.floaterm_keymap_next = "<F2>"
  vim.g.floaterm_keymap_prev = "<F3>"
end

-- Setup function
function M.setup()
  local wk_helper = get_wk_helper()
  local terminal_plugins = check_terminal_plugins()
  
  if not (terminal_plugins.floaterm or terminal_plugins.native_terminal) then
    vim.notify("Terminal plugins not available, skipping terminal keymaps", vim.log.levels.WARN)
    return false
  end
  
  -- Setup floaterm configuration if available
  if terminal_plugins.floaterm then
    setup_floaterm_config()
  end
  
  -- Define terminal keymaps with descriptions
  local terminal_mappings = {}
  
  -- Floaterm keymaps
  if terminal_plugins.floaterm then
    local floaterm_mappings = {
      -- Basic floaterm operations
      { "<leader>t", "<cmd>FloatermToggle<CR>", desc = "Toggle terminal", mode = "n" },
      { "<leader>tt", "<cmd>FloatermToggle<CR>", desc = "Toggle terminal", mode = "n" },
      { "<leader>tn", "<cmd>FloatermNew<CR>", desc = "New terminal", mode = "n" },
      { "<leader>tk", "<cmd>FloatermKill<CR>", desc = "Kill terminal", mode = "n" },
      { "<leader>tK", "<cmd>FloatermKill!<CR>", desc = "Kill all terminals", mode = "n" },
      
      -- Floaterm navigation
      { "<leader>tl", "<cmd>FloatermNext<CR>", desc = "Next terminal", mode = "n" },
      { "<leader>th", "<cmd>FloatermPrev<CR>", desc = "Previous terminal", mode = "n" },
      { "<leader>tf", "<cmd>FloatermFirst<CR>", desc = "First terminal", mode = "n" },
      { "<leader>tL", "<cmd>FloatermLast<CR>", desc = "Last terminal", mode = "n" },
      
      -- Floaterm with specific commands
      { "<leader>tg", "<cmd>FloatermNew lazygit<CR>", desc = "Terminal lazygit", mode = "n" },
      { "<leader>tr", "<cmd>FloatermNew ranger<CR>", desc = "Terminal ranger", mode = "n" },
      { "<leader>ty", "<cmd>FloatermNew yazi<CR>", desc = "Terminal yazi", mode = "n" },
      { "<leader>tb", "<cmd>FloatermNew btop<CR>", desc = "Terminal btop", mode = "n" },
      { "<leader>th", "<cmd>FloatermNew htop<CR>", desc = "Terminal htop", mode = "n" },
      
      -- Floaterm send commands
      { "<leader>ts", function()
          local cmd = vim.fn.input("Send to terminal: ")
          if cmd ~= "" then
            vim.cmd("FloatermSend " .. cmd)
          end
        end,
        desc = "Send command to terminal",
        mode = "n"
      },
      
      { "<leader>tS", function()
          -- Send current line to terminal
          local line = vim.api.nvim_get_current_line()
          vim.cmd("FloatermSend " .. line)
        end,
        desc = "Send current line to terminal",
        mode = "n"
      },
      
      { "<leader>ts", function()
          -- Send selected text to terminal
          local start_pos = vim.fn.getpos("'<")
          local end_pos = vim.fn.getpos("'>")
          local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
          if #lines > 0 then
            local text = table.concat(lines, "\n")
            vim.cmd("FloatermSend " .. text)
          end
        end,
        desc = "Send selection to terminal",
        mode = "v"
      },
      
      -- Floaterm show/hide
      { "<leader>tT", "<cmd>FloatermShow<CR>", desc = "Show terminal", mode = "n" },
      { "<leader>tH", "<cmd>FloatermHide<CR>", desc = "Hide terminal", mode = "n" },
      
      -- Function key shortcuts (documented for which-key)
      { "<F12>", "<cmd>FloatermToggle<CR>", desc = "Toggle terminal", mode = { "n", "i", "t" } },
      { "<F10>", "<cmd>FloatermNew<CR>", desc = "New terminal", mode = { "n", "i", "t" } },
      { "<F8>", "<cmd>FloatermKill<CR>", desc = "Kill terminal", mode = { "n", "i", "t" } },
      { "<F2>", "<cmd>FloatermNext<CR>", desc = "Next terminal", mode = { "n", "i", "t" } },
      { "<F3>", "<cmd>FloatermPrev<CR>", desc = "Previous terminal", mode = { "n", "i", "t" } },
    }
    
    -- Add floaterm mappings to the main list
    for _, mapping in ipairs(floaterm_mappings) do
      table.insert(terminal_mappings, mapping)
    end
  end
  
  -- Native terminal keymaps
  if terminal_plugins.native_terminal then
    local native_terminal_mappings = {
      -- Native terminal operations
      { "<leader>Tt", "<cmd>terminal<CR>", desc = "Open terminal", mode = "n" },
      { "<leader>Tv", "<cmd>vnew | terminal<CR>", desc = "Terminal in vertical split", mode = "n" },
      { "<leader>Th", "<cmd>split | terminal<CR>", desc = "Terminal in horizontal split", mode = "n" },
      { "<leader>Tn", "<cmd>tabnew | terminal<CR>", desc = "Terminal in new tab", mode = "n" },
      
      -- Terminal mode navigation
      { "<C-\\><C-n>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
      { "<C-h>", "<C-\\><C-n><C-w>h", desc = "Move to left window", mode = "t" },
      { "<C-j>", "<C-\\><C-n><C-w>j", desc = "Move to bottom window", mode = "t" },
      { "<C-k>", "<C-\\><C-n><C-w>k", desc = "Move to top window", mode = "t" },
      { "<C-l>", "<C-\\><C-n><C-w>l", desc = "Move to right window", mode = "t" },
      
      -- Terminal utilities
      { "<leader>Tc", function()
          local cmd = vim.fn.input("Run command: ")
          if cmd ~= "" then
            vim.cmd("terminal " .. cmd)
          end
        end,
        desc = "Run command in terminal",
        mode = "n"
      },
    }
    
    -- Add native terminal mappings to the main list
    for _, mapping in ipairs(native_terminal_mappings) do
      table.insert(terminal_mappings, mapping)
    end
  end
  
  -- Terminal workflow keymaps
  local workflow_mappings = {
    -- Project-specific terminals
    { "<leader>tp", function()
        local project_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if project_root and project_root ~= "" then
          if terminal_plugins.floaterm then
            vim.cmd("FloatermNew --cwd=" .. project_root)
          else
            vim.cmd("cd " .. project_root .. " | terminal")
          end
        else
          if terminal_plugins.floaterm then
            vim.cmd("FloatermNew")
          else
            vim.cmd("terminal")
          end
        end
      end,
      desc = "Terminal in project root",
      mode = "n"
    },
    
    -- Development servers
    { "<leader>td", function()
        local servers = {
          "npm run dev",
          "yarn dev", 
          "bundle exec rails server",
          "python manage.py runserver",
          "go run main.go",
          "cargo run"
        }
        
        vim.ui.select(servers, {
          prompt = "Select development server:",
        }, function(choice)
          if choice and terminal_plugins.floaterm then
            vim.cmd("FloatermNew " .. choice)
          elseif choice then
            vim.cmd("terminal " .. choice)
          end
        end)
      end,
      desc = "Run development server",
      mode = "n"
    },
    
    -- Quick commands
    { "<leader>tc", function()
        local common_commands = {
          "git status",
          "git log --oneline",
          "ls -la",
          "pwd",
          "df -h",
          "ps aux",
          "top",
        }
        
        vim.ui.select(common_commands, {
          prompt = "Select command:",
        }, function(choice)
          if choice then
            if terminal_plugins.floaterm then
              vim.cmd("FloatermNew " .. choice)
            else
              vim.cmd("terminal " .. choice)
            end
          end
        end)
      end,
      desc = "Run common command",
      mode = "n"
    },
    
    -- Terminal help
    { "<leader>t?", function()
        print("Terminal keymaps available:")
        if terminal_plugins.floaterm then
          print("  t/tt - Toggle    tn - New       tk - Kill")
          print("  tl/th - Next/Prev    tg - LazyGit    tr - Ranger")
          print("  ts - Send cmd    tS - Send line    tp - Project root")
          print("  F12 - Toggle    F10 - New    F8 - Kill")
        end
        if terminal_plugins.native_terminal then
          print("  Tt - Terminal    Tv - Vsplit    Th - Hsplit")
          print("  Terminal mode: <C-\\><C-n> to exit, <C-hjkl> to navigate")
        end
      end,
      desc = "Show terminal keymap help",
      mode = "n"
    },
  }
  
  -- Add workflow mappings
  for _, mapping in ipairs(workflow_mappings) do
    table.insert(terminal_mappings, mapping)
  end
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(terminal_mappings) do
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
    wk_helper.add_keymaps(terminal_mappings)
  end
  
  -- Set up terminal-specific autocommands
  local terminal_augroup = vim.api.nvim_create_augroup("TerminalKeymaps", { clear = true })
  
  -- Auto-insert mode for terminal buffers
  vim.api.nvim_create_autocmd("TermOpen", {
    group = terminal_augroup,
    pattern = "*",
    callback = function()
      -- Disable line numbers in terminal
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      
      -- Start in insert mode
      vim.cmd("startinsert")
    end,
  })
  
  -- Auto-close terminal on exit
  vim.api.nvim_create_autocmd("TermClose", {
    group = terminal_augroup,
    pattern = "*",
    callback = function()
      -- Close terminal buffer when process exits successfully
      if vim.v.event.status == 0 then
        vim.cmd("bdelete!")
      end
    end,
  })
  
  -- Better terminal colors
  if terminal_plugins.native_terminal then
    vim.opt.termguicolors = true
  end
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  floaterm_basic = { "<leader>t", "<leader>tn", "<leader>tk", "<leader>tt" },
  floaterm_nav = { "<leader>tl", "<leader>th", "<leader>tf", "<leader>tL" },
  floaterm_apps = { "<leader>tg", "<leader>tr", "<leader>ty", "<leader>tb" },
  floaterm_send = { "<leader>ts", "<leader>tS" },
  floaterm_function_keys = { "<F12>", "<F10>", "<F8>", "<F2>", "<F3>" },
  native_terminal = { "<leader>Tt", "<leader>Tv", "<leader>Th", "<leader>Tn" },
  terminal_mode = { "<C-\\><C-n>", "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
  workflow = { "<leader>tp", "<leader>td", "<leader>tc" },
}

return M