-- config/keymaps/ai.lua
-- AI and Copilot integration keymaps
-- Provides comprehensive AI assistance and code completion integration

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Check if AI-related plugins are available
local function check_ai_plugins()
  local plugins = {
    copilot = vim.fn.exists(":Copilot") == 2 or pcall(require, "copilot"),
    copilot_chat = pcall(require, "CopilotChat") or vim.fn.exists(":CopilotChat") == 2,
    copilot_cmp = pcall(require, "copilot_cmp"),
  }
  return plugins
end

-- Setup function
function M.setup()
  local wk_helper = get_wk_helper()
  local ai_plugins = check_ai_plugins()
  
  if not (ai_plugins.copilot or ai_plugins.copilot_chat) then
    vim.notify("AI plugins not available, skipping AI keymaps", vim.log.levels.WARN)
    return false
  end
  
  -- Define AI keymaps with descriptions
  local ai_mappings = {}
  
  -- Core Copilot keymaps
  if ai_plugins.copilot then
    local copilot_mappings = {
      -- Copilot enable/disable
      { "<leader>ae", "<cmd>Copilot enable<CR>", desc = "Enable Copilot", mode = "n" },
      { "<leader>ad", "<cmd>Copilot disable<CR>", desc = "Disable Copilot", mode = "n" },
      { "<leader>at", "<cmd>Copilot toggle<CR>", desc = "Toggle Copilot", mode = "n" },
      
      -- Copilot status and auth
      { "<leader>as", "<cmd>Copilot status<CR>", desc = "Copilot status", mode = "n" },
      { "<leader>aS", "<cmd>Copilot setup<CR>", desc = "Copilot setup", mode = "n" },
      { "<leader>au", "<cmd>Copilot auth<CR>", desc = "Copilot auth", mode = "n" },
      
      -- Copilot suggestions (insert mode)
      { "<C-l>", function()
          if vim.fn.exists("*copilot#Accept") == 1 then
            return vim.fn["copilot#Accept"]("\\<CR>")
          else
            return "<C-l>"
          end
        end,
        desc = "Accept Copilot suggestion",
        mode = "i",
        expr = true,
        silent = true
      },
      
      { "<C-j>", function()
          if vim.fn.exists("*copilot#Next") == 1 then
            return vim.fn["copilot#Next"]()
          else
            return "<C-j>"
          end
        end,
        desc = "Next Copilot suggestion",
        mode = "i",
        expr = true,
        silent = true
      },
      
      { "<C-k>", function()
          if vim.fn.exists("*copilot#Previous") == 1 then
            return vim.fn["copilot#Previous"]()
          else
            return "<C-k>"
          end
        end,
        desc = "Previous Copilot suggestion",
        mode = "i",
        expr = true,
        silent = true
      },
      
      { "<C-h>", function()
          if vim.fn.exists("*copilot#Dismiss") == 1 then
            return vim.fn["copilot#Dismiss"]()
          else
            return "<C-h>"
          end
        end,
        desc = "Dismiss Copilot suggestion",
        mode = "i",
        expr = true,
        silent = true
      },
      
      -- Copilot panel
      { "<leader>ap", "<cmd>Copilot panel<CR>", desc = "Copilot panel", mode = "n" },
      { "<leader>aP", function()
          vim.cmd("Copilot panel")
          vim.cmd("wincmd p")  -- Return to previous window
        end,
        desc = "Copilot panel (stay in current buffer)",
        mode = "n"
      },
    }
    
    -- Add copilot mappings to the main list
    for _, mapping in ipairs(copilot_mappings) do
      table.insert(ai_mappings, mapping)
    end
  end
  
  -- CopilotChat integration
  if ai_plugins.copilot_chat then
    local chat_mappings = {
      -- Basic chat operations
      { "<leader>aa", "<cmd>CopilotChatToggle<CR>", desc = "AI chat toggle", mode = "n" },
      { "<leader>ao", "<cmd>CopilotChatOpen<CR>", desc = "AI chat open", mode = "n" },
      { "<leader>ac", "<cmd>CopilotChatClose<CR>", desc = "AI chat close", mode = "n" },
      { "<leader>ar", "<cmd>CopilotChatReset<CR>", desc = "AI chat reset", mode = "n" },
      { "<leader>ax", "<cmd>CopilotChatReset<CR>", desc = "AI reset", mode = "n" },
      { "<leader>aX", "<cmd>CopilotChatStop<CR>", desc = "AI stop", mode = "n" },
      
      -- Chat models and configuration
      { "<leader>am", "<cmd>CopilotChatModels<CR>", desc = "AI select models", mode = "n" },
      { "<leader>aM", function()
          vim.cmd("CopilotChatModels")
          print("Available models loaded")
        end,
        desc = "AI models info",
        mode = "n"
      },
      
      -- Quick chat
      { "<leader>aq", function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { 
              selection = require("CopilotChat.select").buffer 
            })
          end
        end,
        desc = "AI quick chat",
        mode = "n"
      },
      
      { "<leader>aQ", function()
          local input = vim.fn.input("Quick Chat (selection): ")
          if input ~= "" then
            require("CopilotChat").ask(input, { 
              selection = require("CopilotChat.select").visual 
            })
          end
        end,
        desc = "AI quick chat with selection",
        mode = "v"
      },
      
      -- Predefined prompts
      { "<leader>ae", function()
          require("CopilotChat").ask("Explain this code", {
            selection = require("CopilotChat.select").visual
          })
        end,
        desc = "AI explain code",
        mode = "v"
      },
      
      { "<leader>ar", function()
          require("CopilotChat").ask("Review this code for potential improvements", {
            selection = require("CopilotChat.select").visual
          })
        end,
        desc = "AI review code",
        mode = "v"
      },
      
      { "<leader>af", function()
          require("CopilotChat").ask("Fix the bugs in this code", {
            selection = require("CopilotChat.select").visual
          })
        end,
        desc = "AI fix code",
        mode = "v"
      },
      
      { "<leader>ao", function()
          require("CopilotChat").ask("Optimize this code for better performance", {
            selection = require("CopilotChat.select").visual
          })
        end,
        desc = "AI optimize code",
        mode = "v"
      },
      
      { "<leader>at", function()
          require("CopilotChat").ask("Generate unit tests for this code", {
            selection = require("CopilotChat.select").visual
          })
        end,
        desc = "AI generate tests",
        mode = "v"
      },
      
      { "<leader>ad", function()
          require("CopilotChat").ask("Add comprehensive documentation to this code", {
            selection = require("CopilotChat.select").visual
          })
        end,
        desc = "AI add documentation",
        mode = "v"
      },
      
      -- Chat with different contexts
      { "<leader>ab", function()
          require("CopilotChat").ask("Analyze this entire buffer", {
            selection = require("CopilotChat.select").buffer
          })
        end,
        desc = "AI analyze buffer",
        mode = "n"
      },
      
      { "<leader>al", function()
          require("CopilotChat").ask("Explain this line", {
            selection = require("CopilotChat.select").line
          })
        end,
        desc = "AI explain line",
        mode = "n"
      },
    }
    
    -- Add chat mappings to the main list
    for _, mapping in ipairs(chat_mappings) do
      table.insert(ai_mappings, mapping)
    end
  end
  
  -- General AI workflow keymaps
  local workflow_mappings = {
    -- AI-assisted development workflow
    { "<leader>aw", function()
        -- Quick workflow: explain, review, then optimize selection
        if ai_plugins.copilot_chat then
          local selection = require("CopilotChat.select").visual
          require("CopilotChat").ask("First explain this code, then review it for improvements, and finally suggest optimizations", {
            selection = selection
          })
        else
          print("CopilotChat not available for workflow")
        end
      end,
      desc = "AI workflow (explain → review → optimize)",
      mode = "v"
    },
    
    -- Context-aware assistance
    { "<leader>ac", function()
        local filetype = vim.bo.filetype
        local input = vim.fn.input(string.format("AI assistance for %s: ", filetype))
        if input ~= "" and ai_plugins.copilot_chat then
          require("CopilotChat").ask(
            string.format("For this %s code: %s", filetype, input),
            { selection = require("CopilotChat.select").buffer }
          )
        end
      end,
      desc = "AI context-aware help",
      mode = "n"
    },
    
    -- Help for AI commands
    { "<leader>a?", function()
        print("AI keymaps available:")
        print("  aa - Toggle chat    aq - Quick chat    ae - Explain")
        print("  ar - Review code    af - Fix bugs      ao - Optimize")
        print("  at - Generate tests ad - Add docs      ab - Analyze buffer")
        print("  ap - Panel          as - Status        at - Toggle")
        print("  Insert mode: <C-l> Accept, <C-j>/<C-k> Next/Prev, <C-h> Dismiss")
      end,
      desc = "Show AI keymap help",
      mode = "n"
    },
    
    -- Emergency AI disable (if suggestions are interfering)
    { "<leader>a!", function()
        if ai_plugins.copilot then
          vim.cmd("Copilot disable")
        end
        if ai_plugins.copilot_chat then
          vim.cmd("CopilotChatClose")
        end
        vim.notify("All AI features disabled")
      end,
      desc = "Emergency AI disable",
      mode = "n"
    },
  }
  
  -- Add workflow mappings
  for _, mapping in ipairs(workflow_mappings) do
    table.insert(ai_mappings, mapping)
  end
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(ai_mappings) do
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
    wk_helper.add_keymaps(ai_mappings)
  end
  
  -- Set up AI-specific autocommands
  local ai_augroup = vim.api.nvim_create_augroup("AiKeymaps", { clear = true })
  
  -- Auto-enable Copilot for specific file types
  vim.api.nvim_create_autocmd("FileType", {
    group = ai_augroup,
    pattern = { "lua", "python", "javascript", "typescript", "go", "rust", "ruby" },
    callback = function()
      if ai_plugins.copilot then
        vim.cmd("Copilot enable")
      end
    end,
  })
  
  -- Disable Copilot for certain file types
  vim.api.nvim_create_autocmd("FileType", {
    group = ai_augroup,
    pattern = { "markdown", "text", "gitcommit", "gitrebase" },
    callback = function()
      if ai_plugins.copilot then
        vim.cmd("Copilot disable")
      end
    end,
  })
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  copilot_control = { "<leader>ae", "<leader>ad", "<leader>at", "<leader>as" },
  copilot_suggestions = { "<C-l>", "<C-j>", "<C-k>", "<C-h>" },
  chat_basic = { "<leader>aa", "<leader>ao", "<leader>aq", "<leader>ar" },
  chat_prompts = { "<leader>ae", "<leader>af", "<leader>ao", "<leader>at" },
  workflow = { "<leader>aw", "<leader>ac", "<leader>ab" },
  emergency = { "<leader>a!" },
}

return M