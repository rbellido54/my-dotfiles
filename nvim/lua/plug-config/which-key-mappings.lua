local wk = require("which-key")

local vmaps = {}
local nmaps = {
	{ "<leader>/", "<cmd>Commentary<cr>", desc = "Comment/uncomment line", remap = false },
	{ "<leader>G", "<cmd>RG<cr>", desc = "RipGrep", remap = false },
	{ "<leader>a", group = "AI - Copilot", remap = false },
	{ "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - toggle", remap = false },
	{ "<leader>aq", "<function 1>", desc = "CopilotChat - quick chat", remap = false },
	{ "<leader>ax", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - reset", remap = false },
	{ "<leader>b", group = "Buffer", remap = false },
	{ "<leader>b", "<cmd>Buffers<cr>", desc = "Buffers", remap = false },
	{ "<leader>bl", "<cmd>BLines<cr>", desc = "Search by line in buffer", remap = false },
	{ "<leader>bq", "<c-u>bp <bar> bd #<cr>", desc = "Close current buffer and move to previous one", remap = false },
	{ "<leader>c", "<cmd>Commands<cr>", desc = "Commands", remap = false },
	{ "<leader>g", "<cmd>Rg<cr>", desc = "RipGrep", remap = false },
	{ "<leader>gj", desc = "<plug>(signify-next-hunk)", remap = false },
	{ "<leader>gk", desc = "<plug>(signify-prev-hunk)", remap = false },
	{ "<leader>gs", "<cmd>Ag<cr>", desc = "Silver Searcher", remap = false },
	{ "<leader>h", "<cmd>nohlsearch<cr>", desc = "Toggle search highlights", remap = false },
	{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit", remap = false },
	{ "<leader>m", "<cmd>Marks<cr>", desc = "Marks", remap = false },
	{ "<leader>t", "<cmd>Tags<cr>", desc = "Tags", remap = false },
	{ "<leader>th", "<cmd>Colors<cr>", desc = "Themes", remap = false },
	{ "<leader>gg", "<cmd>GGrep<cr>", desc = "Git Grep", mode = { "n", "n" }, remap = false },
}

wk.add(nmaps)
wk.add(vmaps)
