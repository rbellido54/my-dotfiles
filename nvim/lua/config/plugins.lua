-- plugins.lua
-- Lazy.nvim plugin configuration
-- Migrated from vim-plug/plugins.vim

-- Bootstrap lazy.nvim if needed (this is handled by plugin-manager.lua)

-- Plugin configurations
local plugins = {
  -- Better Syntax Support
  {
    "sheerun/vim-polyglot",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- Disable some polyglot features for better performance
      vim.g.polyglot_disabled = { "sensible" }
    end,
  },

  -- Auto pairs for '(' '[' '{'
  {
    "jiangmiao/auto-pairs",
    event = "InsertEnter",
    config = function()
      -- Configure auto-pairs if needed
      vim.g.AutoPairsShortcutToggle = ""  -- Disable default toggle
    end,
  },

  -- File explorers
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFindFile" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in explorer" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
        },
        renderer = {
          icons = {
            glyphs = {
              default = "",
              symlink = "",
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".git", "node_modules", ".cache" },
        },
      })
    end,
  },

  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
  },

  -- THEMES
  {
    "joshdick/onedark.vim",
    lazy = true,
  },
  {
    "chriskempson/base16-vim",
    lazy = true,
  },
  {
    "rafamadriz/neon",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    branch = "main",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,  -- Load immediately since this is our default theme
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          terminal_colors = true,
        }
      })
    end,
  },
  {
    "sainnhe/everforest",
    lazy = true,
    config = function()
      vim.g.everforest_style = "soft"
      vim.g.everforest_transparent_background = 0
    end,
  },
  {
    "ajmwagar/vim-deus",
    lazy = true,
  },
  {
    "mhartington/oceanic-next",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        transparent = false,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          nvimtree = true,
          which_key = true,
        },
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        transparent_mode = false,
      })
    end,
  },
  {
    "yorickpeterse/vim-paper",
    lazy = true,
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = true,
  },

  -- Native LSP - Mason Ecosystem
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ruby_lsp",
          "ts_ls",
          "pyright",
          "gopls",
          "rust_analyzer",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      -- Basic LSP configuration will be loaded from plug-config/lsp.lua if it exists
      -- This ensures compatibility with existing configurations
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      
      -- Setup common LSP servers with basic configuration
      local servers = { "lua_ls", "ruby_lsp", "ts_ls", "pyright", "gopls", "rust_analyzer" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end
    end,
  },

  -- Airline status
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    event = "VimEnter",
    config = function()
      -- Airline will be configured by themes/airline.vim
      -- This ensures it loads after the theme is set
    end,
  },

  -- Which key plugin
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", "<c-r>", "g", "z", '"', "'", "`", "c", "v", "d" },
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        window = {
          border = "rounded",
        },
      })
    end,
  },

  -- Vim commentary plugin
  {
    "tpope/vim-commentary",
    keys = {
      { "gc", mode = { "n", "v" } },
      { "gcc" },
    },
  },

  -- Quick scope plugin
  {
    "unblevable/quick-scope",
    keys = { "f", "F", "t", "T" },
  },

  -- neovim colorizer
  {
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer" },
    ft = { "css", "scss", "html", "javascript", "typescript", "lua", "vim" },
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "scss", "html", "javascript", "typescript", "lua", "vim" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
        },
      })
    end,
  },

  -- FZF plugin
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
    config = function()
      -- Configure FZF options
      vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --info=inline"
      vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --follow --glob '!{.git,node_modules}'"
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "fzf" },
    cmd = { "Files", "Buffers", "Rg", "Lines", "BLines", "History", "Commands" },
    keys = {
      { "<C-f>", "<cmd>Files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Rg<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Buffers<cr>", desc = "Find buffers" },
      { "<leader>fl", "<cmd>Lines<cr>", desc = "Search lines" },
      { "<leader>fh", "<cmd>History<cr>", desc = "File history" },
      { "<leader>fc", "<cmd>Commands<cr>", desc = "Commands" },
    },
    config = function()
      -- Configure FZF.vim settings
      vim.g.fzf_action = {
        ["ctrl-t"] = "tab split",
        ["ctrl-x"] = "split",
        ["ctrl-v"] = "vsplit"
      }
      
      -- Customize FZF colors to match colorscheme
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
    end,
  },
  {
    "airblade/vim-rooter",
    event = "BufReadPost",
    config = function()
      -- Configure vim-rooter
      vim.g.rooter_patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "go.mod", "*.sln" }
      vim.g.rooter_change_directory_for_non_project_files = "current"
      vim.g.rooter_silent_chdir = 1
    end,
  },

  -- Sneak
  {
    "justinmk/vim-sneak",
    keys = { 
      { "s", mode = { "n", "x" } },
      { "S", mode = { "n", "x" } },
    },
    config = function()
      -- Configure vim-sneak
      vim.g["sneak#label"] = 1
      vim.g["sneak#use_ic_scs"] = 1
      vim.g["sneak#target_labels"] = "sfnjklhodweimbuyvrgtaqpcxz1234567890"
      vim.g["sneak#prompt"] = "🔍 "
      
      -- Highlight settings
      vim.cmd([[
        highlight Sneak guifg=black guibg=red ctermfg=black ctermbg=red
        highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
      ]])
    end,
  },

  -- Startify for funs
  {
    "mhinz/vim-startify",
    event = "VimEnter",
  },

  -- Snippets
  {
    "honza/vim-snippets",
    event = "InsertEnter",
  },

  -- Kill buffer not window
  {
    "qpkorr/vim-bufkill",
    cmd = { "BD", "BUN", "BW" },
    keys = {
      { "<leader>bd", "<cmd>BD<cr>", desc = "Delete buffer" },
      { "<leader>bw", "<cmd>BW<cr>", desc = "Wipeout buffer" },
      { "<leader>bu", "<cmd>BUN<cr>", desc = "Unload buffer" },
    },
    config = function()
      -- Configure vim-bufkill
      -- BD - Delete buffer while preserving window layout
      -- BW - Wipe buffer (completely remove from memory)
      -- BUN - Unload buffer
    end,
  },

  -- Floaterm
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext", "FloatermKill" },
    keys = {
      { "<leader>t", "<cmd>FloatermToggle<cr>", desc = "Toggle terminal" },
      { "<leader>tn", "<cmd>FloatermNew<cr>", desc = "New terminal" },
      { "<leader>tp", "<cmd>FloatermPrev<cr>", desc = "Previous terminal" },
      { "<leader>tl", "<cmd>FloatermNext<cr>", desc = "Next terminal" },
      { "<leader>tk", "<cmd>FloatermKill<cr>", desc = "Kill terminal" },
    },
    config = function()
      -- Configure floaterm
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_position = "center"
      vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
      vim.g.floaterm_title = "Terminal ($1/$2)"
      vim.g.floaterm_keymap_toggle = "<F12>"
      vim.g.floaterm_keymap_new = "<F10>"
      vim.g.floaterm_keymap_kill = "<F8>"
    end,
  },

  -- Zen mode
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
  },

  -- Git integration
  {
    "mhinz/vim-signify",
    event = { "BufReadPost", "BufNewFile" },
    cond = function()
      return vim.fn.isdirectory(".git") == 1 or vim.fn.finddir(".git", ".;") ~= ""
    end,
    config = function()
      -- Configure vim-signify
      vim.g.signify_sign_add = "+"
      vim.g.signify_sign_delete = "-"
      vim.g.signify_sign_delete_first_line = "‾"
      vim.g.signify_sign_change = "~"
      vim.g.signify_sign_changedelete = vim.g.signify_sign_change
      
      -- Faster sign updates
      vim.g.signify_update_on_bufenter = 0
      vim.g.signify_update_on_focusgained = 1
      vim.g.signify_realtime = 1
      
      -- VCS selection
      vim.g.signify_vcs_list = { "git", "hg" }
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = { 
      "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gcommit", "Gwrite", 
      "Gread", "Gdiff", "Gmerge", "Gbrowse", "Gdelete", "Gmove", "Grename"
    },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gb", "<cmd>Gblame<cr>", desc = "Git blame" },
      { "<leader>gc", "<cmd>Gcommit<cr>", desc = "Git commit" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git add current file" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "Git checkout current file" },
      { "<leader>gd", "<cmd>Gdiff<cr>", desc = "Git diff" },
    },
    config = function()
      -- Fugitive is self-configuring, but we can add some helpful settings
      vim.cmd([[
        " Better conflict resolution
        nnoremap <leader>gj :diffget //3<CR>
        nnoremap <leader>gf :diffget //2<CR>
      ]])
    end,
  },
  {
    "tpope/vim-rhubarb",
    dependencies = { "vim-fugitive" },
    cmd = { "GBrowse" },
    keys = {
      { "<leader>go", "<cmd>GBrowse<cr>", desc = "Open in GitHub", mode = { "n", "v" } },
    },
    config = function()
      -- vim-rhubarb provides GitHub integration for fugitive
      -- Enables :GBrowse to open files/selections in GitHub
    end,
  },
  {
    "junegunn/gv.vim",
    dependencies = { "vim-fugitive" },
    cmd = { "GV" },
    keys = {
      { "<leader>gv", "<cmd>GV<cr>", desc = "Git log" },
      { "<leader>gV", "<cmd>GV!<cr>", desc = "Git log for current file" },
      { "<leader>gl", "<cmd>GV --all<cr>", desc = "Git log all branches" },
    },
    config = function()
      -- Configure gv.vim
      vim.g.gv_open_delay = 100
    end,
  },

  -- Vim surround
  {
    "tpope/vim-surround",
    keys = { "ys", "ds", "cs" },
  },

  -- Vim repeat for repeating plugin commands
  {
    "tpope/vim-repeat",
    keys = { "." },
  },

  -- Text object base dependency
  {
    "kana/vim-textobj-user",
    lazy = true,
  },

  -- Ruby text objects
  {
    "tek/vim-textobj-ruby",
    dependencies = { "kana/vim-textobj-user" },
    ft = "ruby",
    config = function()
      -- Ruby text objects are automatically configured
      -- Provides: ar (a ruby block), ir (inner ruby block)
      -- ar (a ruby block), ir (inner ruby block)
      -- am (a ruby method), im (inner ruby method)
    end,
  },

  -- Plugin to add more text objects
  {
    "wellle/targets.vim",
    keys = {
      { "ci", mode = { "x", "o" } },
      { "ca", mode = { "x", "o" } },
      { "di", mode = { "x", "o" } },
      { "da", mode = { "x", "o" } },
      { "yi", mode = { "x", "o" } },
      { "ya", mode = { "x", "o" } },
    },
    config = function()
      -- Configure targets.vim for enhanced text objects
      -- Provides enhanced text objects for:
      -- (, ), [, ], {, }, <, >, ', ", `, t (tag)
      -- Also adds seeking behavior and improvements
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Configure Copilot settings
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Set up custom keymaps for Copilot
      local keymap = vim.keymap.set
      keymap("i", "<C-g>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })
      keymap("i", "<C-;>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      keymap("i", "<C-,>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
      keymap("i", "<C-o>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "github/copilot.vim", "nvim-lua/plenary.nvim" },
    cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatReview" },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain with Copilot", mode = { "n", "v" } },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "Review with Copilot", mode = { "n", "v" } },
    },
    config = function()
      require("CopilotChat").setup({
        debug = false,
        show_help = "yes",
        window = {
          layout = "float",
          width = 0.8,
          height = 0.6,
          border = "rounded",
        },
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "q",
            insert = "<C-c>"
          },
          reset = {
            normal = "<C-r>",
            insert = "<C-r>"
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-s>"
          },
        },
      })
    end,
  },

  -- Lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")
      
      -- Configure linters by filetype
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "pylint" },
        ruby = { "rubocop" },
        lua = { "luacheck" },
        go = { "golangci-lint" },
        rust = { "cargo" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
      }

      -- Set up autocommand to run linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format buffer" },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          ruby = { "rubocop" },
          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          yaml = { { "prettierd", "prettier" } },
          markdown = { { "prettierd", "prettier" } },
          css = { { "prettierd", "prettier" } },
          scss = { { "prettierd", "prettier" } },
          html = { { "prettierd", "prettier" } },
          go = { "goimports", "gofmt" },
          rust = { "rustfmt" },
          sh = { "shfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          shfmt = {
            prepend_args = { "-i", "2" },
          },
        },
      })
    end,
  },

  -- Indent-lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {},
  },
  {
    "lukas-reineke/virt-column.nvim",
    event = "BufReadPost",
  },

  -- For Lua/Neovim development
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- Show marks beside line numbers
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    config = function()
      require("marks").setup()
    end,
  },

  -- Lazygit plugin in neovim
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
      { "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit current file" },
      { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit filter" },
    },
    cond = function()
      return vim.fn.executable("lazygit") == 1
    end,
    config = function()
      -- Configure lazygit integration
      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      vim.g.lazygit_floating_window_corner_chars = {'╭', '╮', '╰', '╯'} -- customize lazygit popup window corner characters
      vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
      vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
    end,
  },

  -- Web dev icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        strict = true,
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
          }
        },
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
          }
        },
      })
    end,
  },
}

-- Setup lazy.nvim with our plugins
require("lazy").setup(plugins, {
  defaults = {
    lazy = true, -- Make plugins lazy by default
    version = false, -- Always use the latest git commit
  },
  install = {
    missing = true, -- Install missing plugins on startup
    colorscheme = { "nightfox", "habamax" }, -- Try to load one of these colorschemes when starting an installation during startup
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- Reset the package path to improve startup time
    rtp = {
      reset = true, -- Reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- Add any custom paths here that you want to includes in the rtp
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
      },
    },
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- Wrap the lines in the ui
    border = "rounded",
    title = "lazy.nvim", ---@type string only works when border is not "none"
    title_pos = "center", ---@type "center" | "left" | "right"
    pills = true, ---@type boolean
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
  checker = {
    enabled = false, -- Don't automatically check for plugin updates
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- Get a notification when new updates are found
    frequency = 3600, -- Check for updates every hour
  },
  change_detection = {
    enabled = true,
    notify = false, -- Get a notification when changes are found
  },
})

-- Notify that lazy.nvim setup is complete
vim.notify("Plugin system loaded with lazy.nvim", vim.log.levels.INFO)