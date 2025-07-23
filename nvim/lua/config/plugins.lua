-- plugins.lua
-- Lazy.nvim plugin configuration
-- Migrated from vim-plug/plugins.vim

-- Bootstrap lazy.nvim if needed
require("config.lazy-bootstrap").setup()

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
    cmd = "colorscheme onedark",
    lazy = true,
  },
  {
    "chriskempson/base16-vim",
    cmd = { "colorscheme base16-default-dark", "colorscheme base16-default-light" },
    lazy = true,
  },
  {
    "rafamadriz/neon",
    cmd = "colorscheme neon",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    branch = "main",
    cmd = { "colorscheme tokyonight", "colorscheme tokyonight-night", "colorscheme tokyonight-storm", "colorscheme tokyonight-day" },
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
    cmd = "colorscheme everforest",
    lazy = true,
    config = function()
      vim.g.everforest_style = "soft"
      vim.g.everforest_transparent_background = 0
    end,
  },
  {
    "ajmwagar/vim-deus",
    cmd = "colorscheme deus",
    lazy = true,
  },
  {
    "mhartington/oceanic-next",
    cmd = "colorscheme OceanicNext",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    cmd = { "colorscheme kanagawa", "colorscheme kanagawa-wave", "colorscheme kanagawa-dragon" },
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
    cmd = { "colorscheme catppuccin", "colorscheme catppuccin-latte", "colorscheme catppuccin-frappe", "colorscheme catppuccin-macchiato", "colorscheme catppuccin-mocha" },
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
    cmd = "colorscheme gruvbox",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        transparent_mode = false,
      })
    end,
  },
  {
    "yorickpeterse/vim-paper",
    cmd = "colorscheme paper",
    lazy = true,
  },
  {
    "eldritch-theme/eldritch.nvim",
    cmd = "colorscheme eldritch",
    lazy = true,
  },

  -- Native LSP
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    event = "BufReadPre",
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = { "mason-lspconfig.nvim" },
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
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "fzf" },
    keys = {
      { "<C-f>", "<cmd>Files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Rg<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Buffers<cr>", desc = "Find buffers" },
    },
  },
  {
    "airblade/vim-rooter",
    event = "BufReadPost",
  },

  -- Sneak
  {
    "justinmk/vim-sneak",
    keys = { "s", "S" },
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
    keys = {
      { "<leader>bd", "<cmd>BD<cr>", desc = "Delete buffer" },
    },
  },

  -- Floaterm
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle" },
    keys = {
      { "<leader>t", "<cmd>FloatermToggle<cr>", desc = "Toggle terminal" },
    },
  },

  -- Zen mode
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
  },

  -- Git integration
  {
    "mhinz/vim-signify",
    event = "BufReadPost",
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },
  {
    "tpope/vim-rhubarb",
    dependencies = { "vim-fugitive" },
    cmd = { "GBrowse" },
  },
  {
    "junegunn/gv.vim",
    dependencies = { "vim-fugitive" },
    cmd = "GV",
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

  -- Ruby text objects
  {
    "tek/vim-textobj-ruby",
    dependencies = { "kana/vim-textobj-user" },
    ft = "ruby",
  },

  -- Plugin to add more text objects
  {
    "wellle/targets.vim",
    keys = {
      { "ci", mode = { "x", "o" } },
      { "ca", mode = { "x", "o" } },
      { "di", mode = { "x", "o" } },
      { "da", mode = { "x", "o" } },
    },
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "github/copilot.vim", "nvim-lua/plenary.nvim" },
    cmd = { "CopilotChat", "CopilotChatToggle" },
  },

  -- Lint
  {
    "mfussenegger/nvim-lint",
    event = "BufReadPost",
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
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
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
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
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
  },
})

-- Notify that lazy.nvim setup is complete
vim.notify("Plugin system loaded with lazy.nvim", vim.log.levels.INFO)