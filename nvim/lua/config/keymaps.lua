-- config/keymaps.lua
-- Modern keymap management system entry point
-- Migrated to modular system with which-key integration

-- Initialize the modern keymap system
local keymap_system = require("config.keymaps.init")

-- Setup the keymap system
keymap_system.setup()

-- Expose the keymap system for external access
return keymap_system