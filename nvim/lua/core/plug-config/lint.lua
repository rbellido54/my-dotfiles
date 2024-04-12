require('lint').linters_by_ft = {
  markdown = {'vale',},
  ruby = {'standardrb'},
  erb = { 'erb_lint' },
  zsh = { 'zsh' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
