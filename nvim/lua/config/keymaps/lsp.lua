-- config/keymaps/lsp.lua
-- LSP and development tool keymaps
-- Provides comprehensive language server and development tool integration

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Check if LSP-related plugins are available
local function check_lsp_plugins()
  local plugins = {
    lspconfig = pcall(require, "lspconfig"),
    mason = pcall(require, "mason"),
    conform = pcall(require, "conform"),
    lint = pcall(require, "lint"),
  }
  return plugins
end

-- LSP diagnostic visibility toggle state
local isLspDiagnosticsVisible = true

-- Setup function
function M.setup()
  local wk_helper = get_wk_helper()
  local lsp_plugins = check_lsp_plugins()
  
  if not lsp_plugins.lspconfig then
    vim.notify("LSP not available, skipping LSP keymaps", vim.log.levels.WARN)
    return false
  end
  
  -- Define LSP keymaps with descriptions
  local lsp_mappings = {}
  
  -- Core LSP navigation and information keymaps
  local core_lsp_mappings = {
    -- Go to definitions and declarations
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration", mode = "n" },
    { "gd", vim.lsp.buf.definition, desc = "Go to definition", mode = "n" },
    { "gi", vim.lsp.buf.implementation, desc = "Go to implementation", mode = "n" },
    { "gr", vim.lsp.buf.references, desc = "Go to references", mode = "n" },
    { "gt", vim.lsp.buf.type_definition, desc = "Go to type definition", mode = "n" },
    
    -- Hover and signature help
    { "K", vim.lsp.buf.hover, desc = "Hover documentation", mode = "n" },
    { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help", mode = "n" },
    { "<leader>lh", vim.lsp.buf.hover, desc = "LSP hover", mode = "n" },
    { "<leader>ls", vim.lsp.buf.signature_help, desc = "LSP signature help", mode = "n" },
    
    -- Code actions and refactoring
    { "<leader>la", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
    { "<leader>lca", vim.lsp.buf.code_action, desc = "Code action", mode = "n" },
    { "<leader>lr", vim.lsp.buf.rename, desc = "Rename symbol", mode = "n" },
    { "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol", mode = "n" },
    
    -- Formatting
    { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format buffer", mode = "n" },
    { "<leader>f", function() vim.lsp.buf.format({ async = true }) end, desc = "Format buffer", mode = "n" },
    { "<leader>lF", function() vim.lsp.buf.format({ async = false }) end, desc = "Format buffer (sync)", mode = "n" },
    
    -- Workspace management
    { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder", mode = "n" },
    { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder", mode = "n" },
    { "<leader>wl", function() 
        print(vim.inspect(vim.lsp.buf.list_workspace_folders())) 
      end, 
      desc = "List workspace folders", 
      mode = "n" 
    },
  }
  
  -- Add core LSP mappings to the main list
  for _, mapping in ipairs(core_lsp_mappings) do
    table.insert(lsp_mappings, mapping)
  end
  
  -- Diagnostic keymaps
  local diagnostic_mappings = {
    -- Diagnostic navigation
    { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic", mode = "n" },
    { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic", mode = "n" },
    { "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next error", mode = "n" },
    { "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Previous error", mode = "n" },
    { "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, desc = "Next warning", mode = "n" },
    { "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, desc = "Previous warning", mode = "n" },
    
    -- Diagnostic information
    { "<leader>ld", vim.diagnostic.open_float, desc = "Line diagnostics", mode = "n" },
    { "<leader>lsd", vim.diagnostic.open_float, desc = "Line diagnostics", mode = "n" },
    { "<leader>lq", vim.diagnostic.setloclist, desc = "Diagnostic quickfix", mode = "n" },
    { "<leader>q", vim.diagnostic.setloclist, desc = "Diagnostic quickfix", mode = "n" },
    
    -- Diagnostic toggle
    { "<leader>lx", function()
        isLspDiagnosticsVisible = not isLspDiagnosticsVisible
        vim.diagnostic.config({
          virtual_text = isLspDiagnosticsVisible,
          underline = isLspDiagnosticsVisible,
        })
        vim.notify("LSP diagnostics " .. (isLspDiagnosticsVisible and "enabled" or "disabled"))
      end, 
      desc = "Toggle LSP diagnostics", 
      mode = "n" 
    },
    { "<leader>lsx", function()
        isLspDiagnosticsVisible = not isLspDiagnosticsVisible
        vim.diagnostic.config({
          virtual_text = isLspDiagnosticsVisible,
          underline = isLspDiagnosticsVisible,
        })
      end, 
      desc = "Toggle LSP diagnostics", 
      mode = "n" 
    },
  }
  
  -- Add diagnostic mappings to the main list
  for _, mapping in ipairs(diagnostic_mappings) do
    table.insert(lsp_mappings, mapping)
  end
  
  -- LSP server management (Mason integration)
  if lsp_plugins.mason then
    local mason_mappings = {
      { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason LSP installer", mode = "n" },
      { "<leader>lM", "<cmd>MasonUpdate<CR>", desc = "Update Mason packages", mode = "n" },
      { "<leader>li", "<cmd>LspInfo<CR>", desc = "LSP info", mode = "n" },
      { "<leader>lI", "<cmd>LspInstallInfo<CR>", desc = "LSP install info", mode = "n" },
    }
    
    for _, mapping in ipairs(mason_mappings) do
      table.insert(lsp_mappings, mapping)
    end
  end
  
  -- LSP server control
  local server_control_mappings = {
    { "<leader>lR", "<cmd>LspRestart<CR>", desc = "Restart LSP", mode = "n" },
    { "<leader>lS", "<cmd>LspStart<CR>", desc = "Start LSP", mode = "n" },
    { "<leader>lT", "<cmd>LspStop<CR>", desc = "Stop LSP", mode = "n" },
    { "<leader>ll", function()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        if #clients == 0 then
          print("No LSP clients attached")
        else
          print("Active LSP clients:")
          for _, client in ipairs(clients) do
            print("  - " .. client.name)
          end
        end
      end, 
      desc = "List active LSP clients", 
      mode = "n" 
    },
  }
  
  -- Add server control mappings
  for _, mapping in ipairs(server_control_mappings) do
    table.insert(lsp_mappings, mapping)
  end
  
  -- Conform formatting integration
  if lsp_plugins.conform then
    local conform_mappings = {
      { "<leader>lc", function()
          require("conform").format({ async = true })
        end,
        desc = "Conform format",
        mode = "n"
      },
      { "<leader>lC", "<cmd>ConformInfo<CR>", desc = "Conform info", mode = "n" },
    }
    
    for _, mapping in ipairs(conform_mappings) do
      table.insert(lsp_mappings, mapping)
    end
  end
  
  -- Lint integration
  if lsp_plugins.lint then
    local lint_mappings = {
      { "<leader>lL", function()
          require("lint").try_lint()
        end,
        desc = "Run linter",
        mode = "n"
      },
      { "<leader>ln", function()
          local linters = require("lint").get_running()
          if #linters == 0 then
            print("No linters running")
          else
            print("Running linters: " .. table.concat(linters, ", "))
          end
        end,
        desc = "Show running linters",
        mode = "n"
      },
    }
    
    for _, mapping in ipairs(lint_mappings) do
      table.insert(lsp_mappings, mapping)
    end
  end
  
  -- Development workflow keymaps
  local workflow_mappings = {
    -- Quick development actions
    { "<leader>lw", function()
        -- Save, format, and lint
        vim.cmd("write")
        vim.lsp.buf.format({ async = false })
        if lsp_plugins.lint then
          require("lint").try_lint()
        end
      end,
      desc = "Save, format, and lint",
      mode = "n"
    },
    
    -- Symbol search
    { "<leader>ly", function()
        vim.lsp.buf.workspace_symbol()
      end,
      desc = "Workspace symbols",
      mode = "n"
    },
    
    { "<leader>lY", function()
        vim.lsp.buf.document_symbol()
      end,
      desc = "Document symbols",
      mode = "n"
    },
    
    -- Incoming/outgoing calls
    { "<leader>lci", vim.lsp.buf.incoming_calls, desc = "Incoming calls", mode = "n" },
    { "<leader>lco", vim.lsp.buf.outgoing_calls, desc = "Outgoing calls", mode = "n" },
    
    -- Help for LSP commands
    { "<leader>l?", function()
        print("LSP keymaps available:")
        print("  gd/gi/gr - Go to definition/implementation/references")
        print("  K - Hover    <C-k> - Signature    la - Code action")
        print("  lr/rn - Rename    lf/f - Format    ld - Diagnostics")
        print("  ]d/[d - Next/Prev diagnostic    lx - Toggle diagnostics")
        print("  lm - Mason    li - LSP info    lR - Restart LSP")
      end,
      desc = "Show LSP keymap help",
      mode = "n"
    },
  }
  
  -- Add workflow mappings
  for _, mapping in ipairs(workflow_mappings) do
    table.insert(lsp_mappings, mapping)
  end
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(lsp_mappings) do
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
    wk_helper.add_keymaps(lsp_mappings)
  end
  
  -- Set up LSP-specific autocommands
  local lsp_augroup = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
  
  -- Auto-save and format on certain events
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_augroup,
    pattern = { "*.lua", "*.go", "*.js", "*.ts", "*.rb" },
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
  
  -- Highlight symbol under cursor
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = lsp_augroup,
    callback = function()
      vim.lsp.buf.document_highlight()
    end,
  })
  
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = lsp_augroup,
    callback = function()
      vim.lsp.buf.clear_references()
    end,
  })
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  navigation = { "gd", "gi", "gr", "gD", "gt" },
  information = { "K", "<C-k>", "<leader>lh", "<leader>ls" },
  actions = { "<leader>la", "<leader>lr", "<leader>rn" },
  formatting = { "<leader>lf", "<leader>f", "<leader>lc" },
  diagnostics = { "]d", "[d", "<leader>ld", "<leader>lx" },
  workspace = { "<leader>wa", "<leader>wr", "<leader>wl" },
  server_control = { "<leader>lR", "<leader>lS", "<leader>lT" },
  tools = { "<leader>lm", "<leader>li", "<leader>ll" },
  workflow = { "<leader>lw", "<leader>ly", "<leader>lY" },
}

return M