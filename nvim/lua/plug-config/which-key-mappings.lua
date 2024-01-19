local wk = require("which-key")

local nmaps = {
  ["<leader>b"] = { "<cmd>Buffers<cr>", "Buffers" },
  ["<leader>c"] = { "<cmd>Commands<cr>", "Commands" },
  ["<leader>g"] = { "<cmd>Rg<cr>", "RipGrep" },
  ["<leader>G"] = { "<cmd>GGrep<cr>", "Git Grep" },
  ["<leader>t"] = { "<cmd>Tags<cr>", "Tags" },
  ["<leader>m"] = { "<cmd>Marks<cr>", "Marks" },
  ["<leader>h"] = { "<cmd>nohlsearch<cr>", "Toggle search highlights" },
  ["<leader>ag"] = { "<cmd>Ag<cr>", "Silver Searcher" },
  ["<leader>/"] = { "<cmd>Commentary<cr>", "Comment/uncomment line" },
  ["<leader>"] = {
    b = {
      name = "Buffer",
      q = { "<c-u>bp <bar> bd #<cr>", "Close current buffer and move to previous one" },
      l = { "<cmd>BLines<cr>", "Search by line in buffer" }
    },
    g = {
      g = { "<cmd>GGrep<cr>", "Git Grep" },
      j = { "<plug>(signify-next-hunk)" },
      k = { "<plug>(signify-prev-hunk)" },
      J = { "9999<leader>gj" },
      K = { "9999<leader>gk" },
    },
  }
}

local vmaps = {

}

wk.register(nmaps, {mode = "n", noremap = true, silent = true})
wk.register(vmaps, {mode = "v", noremap = true, silent = true})
