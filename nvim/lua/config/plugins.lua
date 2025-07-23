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
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,  -- Load immediately since this is our default theme
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = true,
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
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
  },
  {
    "yorickpeterse/vim-paper",
    lazy = true,
  },
  {
    "eldritch-theme/eldritch.nvim",
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
  },

  -- Which key plugin
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
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
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
    config = function()
      require("colorizer").setup()
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