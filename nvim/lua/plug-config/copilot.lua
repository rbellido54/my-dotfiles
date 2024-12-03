-- Copilot autosuggestions
vim.g.copilot_no_tab_map = true
vim.g.copilot_hide_during_completion = 0
vim.g.copilot_proxy_strict_ssl = 0
vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})

local chat = require("CopilotChat")
local select = require("CopilotChat.select")

chat.setup({
	debug = true,
	log_level = "debug",
	model = "gpt-4o",
	selection = select.visual,
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

	-- default mappings
	mappings = {
		complete = {
			insert = "<Tab>",
		},
		close = {
			normal = "q",
			insert = "<C-c>",
		},
		reset = {
			normal = "",
			insert = "",
		},
		submit_prompt = {
			normal = "<CR>",
			insert = "",
		},
		toggle_sticky = {
			detail = "Makes line under cursor sticky or deletes sticky line.",
			normal = "gr",
		},
		accept_diff = {
			normal = "<C-y>",
			insert = "<C-y>",
		},
		jump_to_diff = {
			normal = "gj",
		},
		quickfix_diffs = {
			normal = "gq",
		},
		yank_diff = {
			normal = "gy",
			register = '"',
		},
		show_diff = {
			normal = "gd",
		},
		show_info = {
			normal = "gi",
		},
		show_context = {
			normal = "gc",
		},
		show_help = {
			normal = "gh",
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>aq", function()
	vim.ui.input({
		prompt = "AI Question> ",
	}, function(input)
		if input and input ~= "" then
			chat.ask(input)
		end
	end)
end, { desc = "AI Question" })
