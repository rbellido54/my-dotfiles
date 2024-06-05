require("conform").setup({
  formatters_by_ft = {
    ruby = { "standardrb" },
    go = { "gofmt" },
    yaml = { "yamlfmt" },
    erb = { "erb-formatter" },
    html = { "prettier" },
    css = { "prettier" },
    shell = { "shfmt" },
    ts = { "ts-standard" }
  },
  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  -- format_on_save = {
  -- I recommend these options. See :help conform.format for details.
  -- lsp_fallback = true,
  -- timeout_ms = 100,
  -- },
  -- If this is set, Conform will run the formatter asynchronously after save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_after_save = {
    lsp_fallback = true,
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
