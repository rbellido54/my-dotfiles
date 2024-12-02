-- require("copilot").setup({
-- 	panel = {
-- 		enabled = true,
-- 		auto_refresh = true,
-- 		keymap = {
-- 			jump_prev = "[[",
-- 			jump_next = "]]",
-- 			accept = "<CR>",
-- 			refresh = "gr",
-- 			open = "<M-CR>",
-- 		},
-- 		layout = {
-- 			position = "bottom", -- | top | left | right
-- 			ratio = 0.4,
-- 		},
-- 	},
-- 	suggestion = {
-- 		enabled = true,
-- 		auto_trigger = true,
-- 		debounce = 75,
-- 		keymap = {
-- 			accept = "<M-c>",
-- 			accept_word = false,
-- 			accept_line = false,
-- 			next = "<M-]>",
-- 			prev = "<M-[>",
-- 			dismiss = "<C-]>",
-- 		},
-- 	},
-- 	filetypes = {
-- 		yaml = false,
-- 		markdown = false,
-- 		help = false,
-- 		gitcommit = false,
-- 		gitrebase = false,
-- 		hgcommit = false,
-- 		svn = false,
-- 		cvs = false,
-- 		["."] = false,
-- 	},
-- 	copilot_node_command = "node", -- Node.js version must be > 16.x
-- 	server_opts_overrides = {},
-- })

-- local prompts = require("CopilotChat.prompts")
-- local select = require("CopilotChat.select")
-- require("CopilotChat").setup({
--   debug = false, -- Enable debug logging
--   proxy = nil, -- [protocol://]host[:port] Use this proxy
--   allow_insecure = false, -- Allow insecure server connections

--   system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
--   model = "gpt-4o", -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
--   temperature = 0.1, -- GPT temperature

--   question_header = "## User ", -- Header to use for user questions
--   answer_header = "## Copilot ", -- Header to use for AI answers
--   error_header = "## Error ", -- Header to use for errors
--   separator = "───", -- Separator to use in chat

--   show_folds = true, -- Shows folds for sections in chat
--   show_help = true, -- Shows help message as virtual lines when waiting for user input
--   auto_follow_cursor = true, -- Auto-follow cursor in chat
--   auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
--   clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
--   highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

--   context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
--   history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
--   callback = nil, -- Callback to use when ask response is received

--   -- default selection (visual or line)
--   selection = function(source)
--     return select.visual(source) or select.line(source)
--   end,

--   -- default prompts
--   prompts = {
--     Explain = {
--       mapping = "<leader>ae",
--       prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
--     },
--     Review = {
--       mapping = "<leader>ar",
--       prompt = "/COPILOT_REVIEW Review the selected code.",
--       -- callback = function(response, source)
--       -- 	-- see config.lua for implementation
--       -- end,
--     },
--     Fix = {
--       mapping = "<leader>af",
--       prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
--     },
--     Optimize = {
--       mapping = "<leader>ao",
--       prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.",
--     },
--     Docs = {
--       mapping = "<leader>ad",
--       prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
--     },
--     Tests = {
--       mapping = "<leader>at",
--       prompt = "/COPILOT_GENERATE Please generate tests for my code.",
--     },
--     FixDiagnostic = {
--       mapping = "<leader>afd",
--       prompt = "Please assist with the following diagnostic issue in file:",
--       selection = select.diagnostics,
--     },
--     Commit = {
--       mapping = "<leader>ac",
--       prompt =
--       "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
--       selection = select.gitdiff,
--     },
--     CommitStaged = {
--       mapping = "<leader>acs",
--       prompt =
--       "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
--       selection = function(source)
--         return select.gitdiff(source, true)
--       end,
--     },
--   },

--   -- default window options
--   window = {
--     layout = "float",       -- 'vertical', 'horizontal', 'float', 'replace'
--     width = 0.5,            -- fractional width of parent, or absolute width in columns when > 1
--     height = 0.5,           -- fractional height of parent, or absolute height in rows when > 1
--     -- Options below only apply to floating windows
--     relative = "editor",    -- 'editor', 'win', 'cursor', 'mouse'
--     border = "single",      -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
--     row = nil,              -- row position of the window, default is centered
--     col = nil,              -- column position of the window, default is centered
--     title = "Copilot Chat", -- title of chat window
--     footer = nil,           -- footer of chat window
--     zindex = 1,             -- determines if window is on top or below other floating windows
--   },

--   -- default mappings
--   mappings = {
--     complete = {
--       detail = "Use @<Tab> or /<Tab> for options.",
--       insert = "<Tab>",
--     },
--     close = {
--       normal = "q",
--       insert = "<C-c>",
--     },
--     reset = {
--       normal = "<C-l>",
--       insert = "<C-l>",
--     },
--     submit_prompt = {
--       normal = "<CR>",
--       insert = "<C-m>",
--     },
--     accept_diff = {
--       normal = "<C-y>",
--       insert = "<C-y>",
--     },
--     yank_diff = {
--       normal = "gy",
--     },
--     show_diff = {
--       normal = "gd",
--     },
--     show_system_prompt = {
--       normal = "gp",
--     },
--     show_user_selection = {
--       normal = "gs",
--     },
--   },
-- })

-- Copilot autosuggestions
vim.g.copilot_hide_during_completion = 0
vim.g.copilot_proxy_strict_ssl = 0

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<M-c>", "<Plug>(copilot-accept-word)")
vim.keymap.set("i", "<M-C-c>", "<Plug>(copilot-accept-line)")

local chat = require("CopilotChat")

chat.setup({
	model = "gpt-4o-2024-08-06",
	debug = true,
	question_header = "",
	answer_header = "",
	error_header = "",
	allow_insecure = true,
	mappings = {
		submit_prompt = {
			insert = "",
		},
		reset = {
			normal = "",
			insert = "",
		},
	},
	prompts = {
		Explain = {
			mapping = "<leader>ae",
			description = "AI Explain",
		},
		Review = {
			mapping = "<leader>ar",
			description = "AI Review",
		},
		Tests = {
			mapping = "<leader>at",
			description = "AI Tests",
		},
		Fix = {
			mapping = "<leader>af",
			description = "AI Fix",
		},
		Optimize = {
			mapping = "<leader>ao",
			description = "AI Optimize",
		},
		Docs = {
			mapping = "<leader>ad",
			description = "AI Documentation",
		},
		CommitStaged = {
			mapping = "<leader>ac",
			description = "AI Generate Commit",
		},
	},
})
