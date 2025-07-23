-- config/keymaps/themes.lua
-- Theme switching and customization keymaps
-- Provides easy switching between available color schemes

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Available themes configuration
local themes = {
  {
    name = "nightfox",
    file = "nightfox.vim",
    description = "Dark theme with blue/purple accents",
    variants = { "nightfox", "dawnfox", "dayfox", "duskfox", "nordfox", "terafox", "carbonfox" }
  },
  {
    name = "gruvbox", 
    file = "gruvbox.vim",
    description = "Retro groove color scheme",
    variants = { "gruvbox" }
  },
  {
    name = "tokyonight",
    file = "tokyonight.vim", 
    description = "Clean, dark theme inspired by Tokyo's neon nights",
    variants = { "tokyonight", "tokyonight-night", "tokyonight-storm", "tokyonight-day" }
  },
  {
    name = "catppuccin",
    file = "catpuccin.vim",
    description = "Soothing pastel theme",
    variants = { "catppuccin", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" }
  },
  {
    name = "kanagawa",
    file = "kanagawa.vim",
    description = "Inspired by Katsushika Hokusai's famous painting",
    variants = { "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" }
  },
  {
    name = "onedark",
    file = "onedark.vim",
    description = "Atom's iconic One Dark theme",
    variants = { "onedark" }
  },
  {
    name = "base16",
    file = "base16.vim",
    description = "Base16 architecture theme",
    variants = { "base16-default-dark", "base16-gruvbox-dark-hard" }
  },
  {
    name = "deus",
    file = "deus.vim", 
    description = "Dark theme with vim-airline integration",
    variants = { "deus" }
  },
  {
    name = "everforest",
    file = "everforest.vim",
    description = "Green based color scheme",
    variants = { "everforest" }
  },
  {
    name = "oceanic-next",
    file = "oceanic-next.vim",
    description = "Oceanic blue theme",
    variants = { "OceanicNext" }
  },
  {
    name = "neon",
    file = "neon.vim",
    description = "Vibrant neon colors",
    variants = { "neon" }
  },
  {
    name = "paper",
    file = "paper.vim",
    description = "Light theme for reading",
    variants = { "paper" }
  },
}

-- Get current theme
local function get_current_theme()
  local current_colorscheme = vim.g.colors_name or "default"
  for _, theme in ipairs(themes) do
    for _, variant in ipairs(theme.variants) do
      if variant == current_colorscheme then
        return theme.name, variant
      end
    end
  end
  return "unknown", current_colorscheme
end

-- Apply theme by loading the theme file
local function apply_theme(theme)
  local theme_path = vim.fn.stdpath("config") .. "/themes/" .. theme.file
  if vim.fn.filereadable(theme_path) == 1 then
    -- Source the theme file
    vim.cmd("source " .. theme_path)
    vim.notify(string.format("Applied theme: %s (%s)", theme.name, theme.description), vim.log.levels.INFO)
    return true
  else
    vim.notify(string.format("Theme file not found: %s", theme_path), vim.log.levels.ERROR)
    return false
  end
end

-- Apply colorscheme variant directly
local function apply_colorscheme(colorscheme)
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if ok then
    vim.notify(string.format("Applied colorscheme: %s", colorscheme), vim.log.levels.INFO)
    return true
  else
    vim.notify(string.format("Colorscheme not available: %s", colorscheme), vim.log.levels.ERROR)
    return false
  end
end

-- Get theme by name
local function get_theme_by_name(name)
  for _, theme in ipairs(themes) do
    if theme.name == name then
      return theme
    end
  end
  return nil
end

-- Setup function
function M.setup()
  local wk_helper = get_wk_helper()
  
  -- Define theme keymaps with descriptions
  local theme_mappings = {
    -- Theme browser and selector
    { "<leader>th", function()
        local theme_names = {}
        for _, theme in ipairs(themes) do
          table.insert(theme_names, string.format("%s - %s", theme.name, theme.description))
        end
        
        vim.ui.select(theme_names, {
          prompt = "Select theme:",
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if choice then
            local theme_name = choice:match("^([^%s]+)")
            local theme = get_theme_by_name(theme_name)
            if theme then
              apply_theme(theme)
            end
          end
        end)
      end,
      desc = "Browse and select themes",
      mode = "n"
    },
    
    -- Quick theme switching
    { "<leader>t1", function() 
        local theme = get_theme_by_name("nightfox")
        if theme then apply_theme(theme) end
      end,
      desc = "Switch to nightfox theme",
      mode = "n"
    },
    
    { "<leader>t2", function()
        local theme = get_theme_by_name("gruvbox") 
        if theme then apply_theme(theme) end
      end,
      desc = "Switch to gruvbox theme",
      mode = "n"
    },
    
    { "<leader>t3", function()
        local theme = get_theme_by_name("tokyonight")
        if theme then apply_theme(theme) end
      end,
      desc = "Switch to tokyonight theme", 
      mode = "n"
    },
    
    { "<leader>t4", function()
        local theme = get_theme_by_name("catppuccin")
        if theme then apply_theme(theme) end
      end,
      desc = "Switch to catppuccin theme",
      mode = "n"
    },
    
    { "<leader>t5", function()
        local theme = get_theme_by_name("kanagawa")
        if theme then apply_theme(theme) end
      end,
      desc = "Switch to kanagawa theme",
      mode = "n"
    },
    
    -- Theme variants (for themes that support them)
    { "<leader>tv", function()
        local current_theme_name, _ = get_current_theme()
        local theme = get_theme_by_name(current_theme_name)
        
        if theme and #theme.variants > 1 then
          vim.ui.select(theme.variants, {
            prompt = string.format("Select %s variant:", theme.name)
          }, function(choice)
            if choice then
              apply_colorscheme(choice)
            end
          end)
        else
          vim.notify("Current theme has no variants available", vim.log.levels.INFO)
        end
      end,
      desc = "Switch theme variants",
      mode = "n"  
    },
    
    -- Theme information
    { "<leader>ti", function()
        local theme_name, colorscheme = get_current_theme()
        local theme = get_theme_by_name(theme_name)
        
        print("Current theme information:")
        print(string.format("  Theme: %s", theme_name))
        print(string.format("  Colorscheme: %s", colorscheme))
        if theme then
          print(string.format("  Description: %s", theme.description))
          print(string.format("  Variants: %s", table.concat(theme.variants, ", ")))
        end
        print(string.format("  Background: %s", vim.o.background))
        print(string.format("  Termguicolors: %s", vim.o.termguicolors and "enabled" or "disabled"))
      end,
      desc = "Show current theme info",
      mode = "n"
    },
    
    -- Background toggle
    { "<leader>tb", function()
        if vim.o.background == "dark" then
          vim.o.background = "light"
          vim.notify("Switched to light background", vim.log.levels.INFO)
        else
          vim.o.background = "dark" 
          vim.notify("Switched to dark background", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle background (dark/light)",
      mode = "n"
    },
    
    -- Color column toggle
    { "<leader>tc", function()
        if vim.wo.colorcolumn == "" then
          vim.wo.colorcolumn = "80"
          vim.notify("Color column enabled at 80", vim.log.levels.INFO)
        else
          vim.wo.colorcolumn = ""
          vim.notify("Color column disabled", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle color column",
      mode = "n"
    },
    
    -- Cursor line toggle
    { "<leader>tl", function()
        vim.wo.cursorline = not vim.wo.cursorline
        vim.notify("Cursor line " .. (vim.wo.cursorline and "enabled" or "disabled"), vim.log.levels.INFO)
      end,
      desc = "Toggle cursor line",
      mode = "n"
    },
    
    -- Line numbers toggle
    { "<leader>tn", function()
        if vim.wo.number or vim.wo.relativenumber then
          vim.wo.number = false
          vim.wo.relativenumber = false
          vim.notify("Line numbers disabled", vim.log.levels.INFO)
        else
          vim.wo.number = true
          vim.wo.relativenumber = true
          vim.notify("Line numbers enabled", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle line numbers",
      mode = "n"
    },
    
    -- Random theme
    { "<leader>tr", function()
        local random_theme = themes[math.random(#themes)]
        apply_theme(random_theme)
      end,
      desc = "Random theme",
      mode = "n"
    },
    
    -- Theme cycling
    { "<leader>t]", function()
        local current_theme_name, _ = get_current_theme()
        local current_index = 1
        
        -- Find current theme index
        for i, theme in ipairs(themes) do
          if theme.name == current_theme_name then
            current_index = i
            break
          end
        end
        
        -- Get next theme (wrap around)
        local next_index = (current_index % #themes) + 1
        apply_theme(themes[next_index])
      end,
      desc = "Next theme",
      mode = "n"
    },
    
    { "<leader>t[", function()
        local current_theme_name, _ = get_current_theme()
        local current_index = 1
        
        -- Find current theme index  
        for i, theme in ipairs(themes) do
          if theme.name == current_theme_name then
            current_index = i
            break
          end
        end
        
        -- Get previous theme (wrap around)
        local prev_index = current_index == 1 and #themes or current_index - 1
        apply_theme(themes[prev_index])
      end,
      desc = "Previous theme", 
      mode = "n"
    },
    
    -- Theme help
    { "<leader>t?", function()
        print("Theme keymaps available:")
        print("  th - Browse themes    t1-t5 - Quick switch")
        print("  tv - Theme variants   ti - Theme info")
        print("  tb - Toggle background   tc - Color column") 
        print("  tl - Cursor line      tn - Line numbers")
        print("  tr - Random theme     t]/t[ - Next/Prev theme")
        print("\nQuick themes:")
        print("  t1 - nightfox    t2 - gruvbox    t3 - tokyonight")
        print("  t4 - catppuccin  t5 - kanagawa")
      end,
      desc = "Show theme keymap help",
      mode = "n"
    },
  }
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(theme_mappings) do
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
    wk_helper.add_keymaps(theme_mappings)
  end
  
  -- Create commands for theme management
  vim.api.nvim_create_user_command("ThemeList", function()
    print("Available themes:")
    for i, theme in ipairs(themes) do
      local current_theme_name, _ = get_current_theme()
      local indicator = theme.name == current_theme_name and " (current)" or ""
      print(string.format("  %d. %s - %s%s", i, theme.name, theme.description, indicator))
    end
  end, { desc = "List all available themes" })
  
  vim.api.nvim_create_user_command("ThemeSwitch", function(opts)
    if opts.args and opts.args ~= "" then
      local theme = get_theme_by_name(opts.args)
      if theme then
        apply_theme(theme)
      else
        vim.notify(string.format("Theme not found: %s", opts.args), vim.log.levels.ERROR)
      end
    else
      vim.notify("Usage: :ThemeSwitch <theme_name>", vim.log.levels.INFO)
    end
  end, { 
    nargs = 1, 
    complete = function()
      local names = {}
      for _, theme in ipairs(themes) do
        table.insert(names, theme.name)
      end
      return names
    end,
    desc = "Switch to a specific theme by name"
  })
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  browser = { "<leader>th", "<leader>ti" },
  quick_switch = { "<leader>t1", "<leader>t2", "<leader>t3", "<leader>t4", "<leader>t5" },
  variants = { "<leader>tv" },
  toggles = { "<leader>tb", "<leader>tc", "<leader>tl", "<leader>tn" },
  navigation = { "<leader>t]", "<leader>t[", "<leader>tr" },
  help = { "<leader>t?" },
}

-- Export themes list for external use
M.themes = themes
M.get_current_theme = get_current_theme
M.apply_theme = apply_theme

return M